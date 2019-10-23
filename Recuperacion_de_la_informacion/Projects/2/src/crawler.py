import os.path
import re
from enum import Enum
from queue import Queue
from sys import argv
from threading import Lock, Thread
from time import sleep, time
from timeit import timeit
from urllib import request

from AdvancedHTMLParser import AdvancedHTMLParser
from w3lib.url import safe_url_string

from words import pThread


class TypesOfPage(Enum):
	""" Enumerate class to representate the kind of pages that can be found when crawling

	```
	@attribute links - This type of page is found when the searched word
	was found without problem
	@attribute didYouMean - This type of page is found when the searched word
	was not found, but the dictionary suggested a similar one with a link
	@attribute notFoundBut - This type of page is found when the word was not
	found, but the dictionary automatically redirected to a similar one
	@attribute notFound - The word was not found at all in the dictionary
	```
	"""
	undetermined = 0
	links = 1		# https://www.duden.de/suchen/dudenonline/computer
	didYouMean = 2	# https://www.duden.de/suchen/dudenonline/facesitting
	notFoundBut = 3	# https://www.duden.de/suchen/dudenonline/facelifting?ls=facesitting&s=facelifting
	notFound = 4	# https://www.duden.de/suchen/dudenonline/mitgedruckt
	word = 5

def checkCodeTime(functionToRun, cycles):
	""" Auxiliar function to check and print the raw time a set of code takes to run """
	elapsedTime = timeit(functionToRun, number=cycles)
	print(f"Time transcurred to run this function {cycles} times:\n{elapsedTime} seconds")

def getHTMLdocument(url):
	"""	Takes an URL, call an http request and return a parser for that page

	Given an URL perform an http request to a safe version (ascii) of it and return
	a parser of the obtained HTML (if any). Otherwise, return -1

	```
	@param url <str> - The non-safe URL to be used

	@return <AdvancedHTMLParser> - An instance of an `AdvancedHTMLParser` initialized with the found HTML
	@return <Int> - A -1 value if the http request raised an exception
	```
	"""

	document = AdvancedHTMLParser()
	safeURL = safe_url_string(url, encoding = 'ascii')

	print(f'Sending GET request to URL:\t\033[34m{safeURL}\033[0m')
	try:
		httpRequest = request.urlopen(safeURL, timeout = 20.0)
	except:
		print('\033[31m*************************************\033[0m')
		print('\033[31mERROR sending httprequest\033[0m')
		print(f'\033[31mHappened in URL: {safeURL}\033[0m')
		print('\033[31m*************************************\033[0m')
		return -1

	if httpRequest is not None:
		code = httpRequest.code
		if code != 200:
			print(f'\033[31mCode received:\t\t\t\033[1;0m{code}\033[0m')
			return -1
		print(f'Code received:\t\t\t\033[1;0m{code}')
		htmlString = httpRequest.read().decode('utf-8')
		document.parseStr(htmlString)
		httpRequest.close()
	return document

def getPageType(page):
	""" Takes a parser of a certain page and returns the type of page it is

	Given an initialized instance of an `AdvancedHTMLParser` this function will
	try to obtain certain key elements to determine what type of page it is.

	```
	@param page <AdvancedHTMLParser> - An initialized instance of an AHTMLP
	to search through

	@return <TypesOfPage> - The correspondent value of that enumerate that seems
	more likely to be given the analysis
	```
	"""

	lead = page.getElementsByClassName('lead')
	paragraph = page.getElementsByClassName('paragraph')
	if len(lead) == 1:
		if len(paragraph) > 0:
			return TypesOfPage.didYouMean
		else:
			return TypesOfPage.links
	elif len(lead) == 2:
		return TypesOfPage.notFoundBut
	if len(paragraph) > 0:
		return TypesOfPage.notFound
	lemma = page.getElementsByClassName('lemma')
	if len(lemma) > 0:
		return TypesOfPage.word
	return TypesOfPage.undetermined

# in: request(https://www.duden.de/suchen/dudenonline/h%C3%B6hen), 'höhen'
# out: '/rechtschreibung/hoehen'
def getWordPage(page, word):
	""" Takes a parser of a links page and returns the link to the word page

	Given a parser of a links page, obtains all the `a` tags with class name
	'vignette__label' and determines which one of those correspond to the
	searched word

	```
	@param page <AdvancedHTMLParser> - An initialized instance of an AHTMLP
	to search through
	@param word <str> - The word whose link is trying to be found

	@return <str> - The reference of the link whose description corresponds
	with the searched word
	```
	"""

	links = page.getElementsByClassName('vignette__label')

	for link in links:
		ref = link.getAttribute('href')
		inner = link.innerHTML
		inner = inner.replace('\xad', '')
		inner = inner.replace('<strong >', '')
		inner = inner.replace('</strong>', '')
		inner = inner.strip()
		inner = inner.lower()
		word = word.lower()

		x = re.search(f"(.*, )?{word}(,.*)?", inner)
		if x is not None:
			return ref
	return -1


def checkResource(path):
	if not os.path.exists(path):
		print(f'\033[31mResource {path} does not exist\n\nAborting process...\033[0m')
	elif not os.path.isfile(path):
		print(f'\033[31mResource {path} is not a file\n\nAborting process...\033[0m')
	else:
		print(f'\033[32mResource {path} found successfully!\033[0m')
		return True
	return False

def main():
	if len(argv) > 2:
		print('\033[33mToo many arguments received\n\033[0m')
		print('Usage:\tpython src/crawler.py [file]')
		print('\033[31m\nAborting process...\033[0m')
		return
	elif len(argv) == 1:
		print('\033[33mNo argument for words file provided\nFalling to default mode. Searching for resources/words...\n\033[0m')
		if not checkResource('resources/words'):
			return
		else:
			wordsFile = open('resources/words')
	else:
		if not checkResource(argv[1]):
			return
		else:
			wordsFile = open(argv[1])

	lastProcessedWordFile = open('resources/lastProcessedWord', 'w')
	englishHerkunftWordsFile = open('resources/englishHerkunftWords', 'a')

	dudenSearch = 'https://www.duden.de/suchen/dudenonline/'
	dudenRoot = 'https://www.duden.de'

	mainTagsQueue = Queue(-1)	# * @Arc @here this is the queue I'm pushing to. Send it to your thread
	qLock = Lock()
	dLock = Lock()

	threads = []

	# Threads execution started here
	for threadID in ["T1", "T2"]:
		t = pThread(threadID, mainTagsQueue, qLock, englishHerkunftWordsFile, dLock, lastProcessedWordFile)
		print(f"Launching thread {threadID}...")
		t.start()
		threads.append(t)

	wordCounter = 1
	accumulatedTime = 0.0

	for word in wordsFile:
		word = word.strip()
		print(f'\033[35m{wordCounter:5}.\t-------------------------------------------------------------\033[0m')
		print(f'Currently processing word:\t\033[1;32m{word}\033[1;0m')
		startTime = time()

		document = getHTMLdocument(dudenSearch + word)

		if document != -1:
			pageType = getPageType(document)
			print(f'Type of page:\t\t\t{pageType}')
			if pageType == TypesOfPage.links:
				wordPage = getWordPage(document, word)

				if wordPage != -1:
					print(f'Word page:\t\t\t\033[34m{dudenRoot}{wordPage}\033[0m')
					wordDocument = getHTMLdocument(dudenRoot + wordPage)
					if wordDocument != -1:
						mainTabloids = wordDocument.getElementsByClassName('tabloid__main-column')

						if len(mainTabloids) == 1:
							qLock.acquire()
							mainTagsQueue.put(mainTabloids[0])
							qLock.release()
							print(f'\t\t\033[32mMain tag enqueued successfully!\033[0m')
						elif len(mainTabloids) == 0:
							print('\033[31mWe could not find a main tab\033[0m')
						else:
							print('\033[31mSomething weird happened when getting the main tag. Manual revision required\033[0m')
				else:
					print('\033[33mThe searched word was not found in the dictionary\033[0m')
			elif pageType == TypesOfPage.didYouMean:
				print(f'\033[33mThe word {word} was not found as it was, but a link to a close one was suggested\033[0m')
			elif pageType == TypesOfPage.notFoundBut:
				print(f'\033[33mThe word {word} was not found as it was, but it was automatically suggested a likely one\033[0m')
			elif pageType == TypesOfPage.notFound:
				print(f'\033[33mThe word does not exist\033[0m')

		elapsedTime = time() - startTime
		print(f'Time to crawl this word: {elapsedTime:.2f} seconds')
		accumulatedTime += elapsedTime
		print('\033[35m\t-------------------------------------------------------------\033[0m')
		wordCounter += 1


	# Wait for threads to finish queue
	while not mainTagsQueue.empty():
		sleep(1)
	#safely kill threads
	for t in threads:
		t.signalStop()
	for t in threads:
		t.join()

	print(f'\t\tTotal execution time: {accumulatedTime:.2f} seconds')


	wordsFile.close()
	englishHerkunftWordsFile.close()
	lastProcessedWordFile.close()

main()
