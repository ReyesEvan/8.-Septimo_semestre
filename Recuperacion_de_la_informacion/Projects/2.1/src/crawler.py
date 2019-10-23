import os.path
import re
from enum import Enum
from queue import Queue
from sys import argv, exit
from threading import Lock, Thread
from time import sleep, time
from timeit import timeit
from urllib import request

from AdvancedHTMLParser import AdvancedHTMLParser
from w3lib.url import safe_url_string

from words import pThread

dudenRoot = 'https://www.duden.de'

def troubleshoot(links):
	httpRequest = None
	attemptsLimit = 5
	for count, link in enumerate(links): # enumerate(links) -> [(0, firstLink), (1, secondLink), ...]
		safeURL = safe_url_string(dudenRoot + link, encoding = 'ascii')

		for _ in range(attemptsLimit):
			try:
				httpRequest = request.urlopen(safeURL, timeout = 20.0)
			except:
				print(f'Http request to {link} failed...')
			if httpRequest is not None:
				return troubleshootResults(count, link)

		attemptsLimit -= 1
	return troubleshootResults(-1, None)

def troubleshootResults(state, link): # abort[1] re-attempt[2] troubleshoot [3] continueFrom[4]
	options = []
	optionsMessage = 'Do you want '
	if state == 0:
		print(f'The program was able to reach the original website at {link}')
		print('Possibly, the problem failed because of a problem on the network')
		print('The recommendation is to re-attempt and continue the execution')
		options = ['1', '2']
		optionsMessage += 'to abort the process [1] or re-attempt [2]?'
	elif state == 1:
		print(f'The program was not able to reach the original website, but it was able to reach the next one at {link}')
		print('Probably the previous link is broken or you do not have the permissions to visualize that site')
		print('It is recommended to continue the execution from this word and ignore the previous one')
		options = ['1', '3']
		optionsMessage += 'to abort the process [1] or continue from the found link [3]?'
	elif state > 1 or state < 5:
		print('The program was able to reach a consequent link, but unable to determine the cause of the error')
		print(f'It is recommended to either abort the program and resume it from {link} or to re-attempt')
		print('\033[36mYou may restart later the execution from this point by running:\033[0m')
		print('\tpython src/crawler.py <last word>\n')
		options = ['1', '2', '3']
		optionsMessage += 'to abort the process [1], re-attempt [2] or continue from the found link [3]?'
	else:
		print('The crawler was not able to reach Duden after trying all the possible links')
		print('This is possibly occasionated because of a soft-ban applied by the site due to an excess of requests')
		print('It is recommended to abort the program and wait some time until the ban ceases, then resume from the last successful word')
		print('\033[36mYou may restart later the execution from this point by running:\033[0m')
		print('\tpython src/crawler.py <last word>\n')
		options = ['1', '2']
		optionsMessage += 'to abort the process [1] or re-attempt [2]?'

	return options, optionsMessage, link

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

def getNextLink(page):
	""" Takes an HTML parser returns the next word and link
	Given an already feed HTML document parser, seeks for the next word to crawl
	by looking into the 'Im Alphabet danach' section and getting the first link it
	finds there.

	```
	@param page <AdvancedHTMLParser> - The existant instance where to seek for the information

	@return nextWord <str>, nextLink <str> - The word found as next one along with its correspondent link
	@return None, None - if there are no links, both returns are None
	```
	"""
	for group in page.getElementsByClassName('hookup__group'):
		h3 = group.getElementsByClassName('hookup__title')
		if h3[0].innerHTML == 'Im Alphabet danach':
			link = group.getElementsByClassName('hookup__link')[0]
			return link.innerHTML, link.getAttribute('href')

	return None, None

def getNextLinks(page):
	""" Takes an HTML parser returns the next word and link
	Given an already feed HTML document parser, seeks for the next word to crawl
	by looking into the 'Im Alphabet danach' section and getting the first link it
	finds there.

	```
	@param page <AdvancedHTMLParser> - The existant instance where to seek for the information

	@return nextWord <str>, nextLink <str> - The word found as next one along with its correspondent link
	@return None, None - if there are no links, both returns are None
	```
	"""
	for group in page.getElementsByClassName('hookup__group'):
		h3 = group.getElementsByClassName('hookup__title')
		if h3[0].innerHTML == 'Im Alphabet danach':
			links = group.getElementsByClassName('hookup__link')
			return list(map(lambda link: [link.innerHTML, link.getAttribute('href')], links))

	return None, None

def main():
	if len(argv) > 2:
		print('\033[33mToo many arguments received\n\033[0m')
		print('Usage:\tpython src/crawler.py [starting word]')
		print('\033[31m\nAborting process...\033[0m')
		return
	elif len(argv) == 1:
		print('\033[33mNo argument for starting word provided\nFalling to default mode. Starting crawl with "Aachen"...\n\033[0m')
		currentWord = 'Aachen'
		currentLink = '/rechtschreibung/Aachen'
	else:
		currentWord = argv[1]
		currentLink = f'/rechtschreibung/{argv[1]}'
		initialPage = getHTMLdocument(dudenRoot + currentLink)
		if initialPage == -1:
			print('\033[33mInitial word not found. Please enter a word with an actual link. Aborting process...\033[0m')
			return
		else:
			print('\033[32mInitial word found!. Starting process...\033[0m')

	lastProcessedWordFile = open('resources/lastProcessedWord', 'w')
	englishHerkunftWordsFile = open('resources/englishHerkunftWords.csv', 'a')

	englishHerkunftWordsFile.seek(0)
	englishHerkunftWordsFile.write(f'word,plural,wortart description,herkunft description\n')

	mainTagsQueue = Queue(-1)
	qLock = dLock = Lock()
	threads = []

	# Threads execution started here
	for threadID in ["T1"]:
	# for threadID in ["T1", "T2"]:
		t = pThread(threadID, mainTagsQueue, qLock, englishHerkunftWordsFile, dLock, lastProcessedWordFile)
		print(f"Launching thread {threadID}...")
		t.start()
		threads.append(t)

	nextWordsAndLinks = []
	wordCounter = 1
	accumulatedTime = 0.0
	attemptsLimit = 5

	while True:
		print(f'\033[35m{wordCounter:5}.\t-------------------------------------------------------------\033[0m')
		print(f'Currently processing word:\t\033[1;32m{currentWord}\033[1;0m')
		startTime = time()

		attempt = 1
		currentPage = -1

		while currentPage == -1:		# Loop until get the HTML document
			print(f'Attempt {attempt}')
			currentPage = getHTMLdocument(dudenRoot + currentLink)
			if attempt == attemptsLimit and currentPage == -1:
				print(f'\033[35m{wordCounter:5}.\t-------------------------------------------------------------\033[0m')
				print(f'\033[33mThe crawler has tried to reach Duden.de unsuccessfully {attemptsLimit} times in a row.\033[0m')

				print('\033[33mStarting troubleshoot...\033[0m')
				options, message, proposedLink = troubleshoot(list(map(lambda tuple: tuple[1], nextWordsAndLinks)))

				answer = 0
				while answer not in options:
					print(message)
					# print('Do you want to abort the process [1], re-attempt [2], continue ?')
					answer = input('\t» ')
				if answer == '1':
					for t in threads:
						t.signalStop()
					for t in threads:
						t.join()

					print(f'\t\tTotal execution time: {accumulatedTime:.2f} seconds')

					englishHerkunftWordsFile.close()
					lastProcessedWordFile.close()
					exit(1)
				elif answer == '2':
					attempt = 0
				elif answer == '3':
					currentLink = proposedLink
					continue
			attempt += 1

		mainTabloids = currentPage.getElementsByClassName('tabloid__main-column')
		if len(mainTabloids) == 1:
			qLock.acquire()
			mainTagsQueue.put(mainTabloids[0])
			qLock.release()
			print(f'\t\t\033[32mMain tag enqueued successfully!\033[0m')
		elif len(mainTabloids) == 0:
			print('\033[31mWe could not find a main tab\033[0m')
		else:
			print('\033[31mSomething weird happened when getting the main tag. Manual revision required\033[0m')

		nextWordsAndLinks = getNextLinks(currentPage)
		if nextWordsAndLinks and nextWordsAndLinks != (None, None):
			currentWord, currentLink = nextWordsAndLinks[0]
		else:
			print('\033[1;31m\tThere are no more words to crawl. Finishing process...\033[0m')
			currentWord = currentLink = None

		elapsedTime = time() - startTime
		print(f'Time to crawl this word: {elapsedTime:.2f} seconds')
		accumulatedTime += elapsedTime
		print('\033[35m\t-------------------------------------------------------------\033[0m')
		wordCounter += 1

		if currentWord is None and currentLink is None:
			break


	# Wait for threads to finish queue
	while not mainTagsQueue.empty():
		sleep(1)
	#safely kill threads
	for t in threads:
		t.signalStop()
	for t in threads:
		t.join()

	print(f'\t\tTotal execution time: {accumulatedTime:.2f} seconds')


	englishHerkunftWordsFile.close()
	lastProcessedWordFile.close()

main()
