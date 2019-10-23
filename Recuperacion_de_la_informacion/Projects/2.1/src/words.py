from time import time, sleep
from timeit import timeit
from random             import random
from queue				import Queue
from threading 			import Lock, Thread
import re
import os

from AdvancedHTMLParser import AdvancedHTMLParser

# def processDocument(title, herkunft):
# 	#print(type(title))
# 	#print(type(herkunft))

# 	# Check if herkunft exists in order to verify if it comes from english
# 	word = title[0].getElementsByClassName('lemma__main')[0].innerHTML.translate({0x00AD: None})
# 	if not herkunft is None:
# 		# print(herkunft.outerHTML)
# 		header = re.search('<p *>.*englisch.*</p>', herkunft.outerHTML)
# 		if header :
# 			print(title[0].getElementsByClassName('lemma__main')[0].innerHTML)
# 			return True, word
# 	# 	return True, word
# 	# return False, word
# 	return False, word

def checkCodeTime(functionToRun, cycles):
	""" Auxiliar function to check and print the raw time a set of code takes to run """
	elapsedTime = timeit(functionToRun, number=cycles)
	print(f"Time transcurred to run this function {cycles} times:\n{elapsedTime} seconds")

def processDocument(document):
	""" Takes a parser and returns values to identify its properties

	@return  Noun <bool>, EnglishHerkunft <bool>, word <str>, plural <str>
	"""
	noun = False
	englischHerkunft = False
	word = None
	plural = None
	wortartVal = None
	herkunft = None


	# Get the currently processing word from the page's header
	title = document.getElementsByClassName('lemma__title')
	word = title[0].getElementsByClassName('lemma__main')[0].innerHTML.translate({0x00AD: None})

	# Get the wortart (part of speech) to check if it's a noun
	tuples = document.getElementsByClassName('tuple')
	wortartVal = ''
	for tuple in tuples:
		if re.search('.*Wortart.*', tuple.getElementsByClassName('tuple__key')[0].innerHTML):
			wortartVal = tuple.getElementsByClassName('tuple__val')[0].innerHTML


	if re.search('.*Substantiv.*', wortartVal): # If it is a Noun
		noun = True
		herkunft = document.getElementById('herkunft')
		if herkunft is not None:
			englisch = re.search('<p *>.*englisch.*</p>', herkunft.outerHTML)
			if englisch:
				englischHerkunft = True

				grammatik = document.getElementById('grammatik')
				if grammatik is not None:
					table = grammatik.getElementsByClassName('wrap-table__flexion')
					if table:
						rows = table.getElementsByTagName('tr')
						for row in rows:
							if re.search('.*Nominativ.*', row.outerHTML):
								rowCells = row.getChildren()
								break
						if rowCells is not None and len(rowCells) > 2:
							plural = rowCells[2].innerHTML
					else:
						children = grammatik.getChildren()
						for child in children:
							if "Plural: " in child.innerHTML:
								splittedString = child.innerHTML.split(',')
								for token in splittedString:
									if "Plural:" in token:
										plural = token.replace(' Plural: ', '')


	return noun, englischHerkunft, word, plural, wortartVal, herkunft.getChildren()[1].text if herkunft is not None else None

class pThread (Thread):

	running = True

	# Thread, Identifier, queue, queuelock, docstream, streamlock, lastProcessedWord
	def __init__(self, threadID, q, ql, ds, dl, lw):
		Thread.__init__(self)
		self.threadID = threadID
		self.q = q
		self.ql = ql
		self.ds = ds
		self.dl = dl
		self.lw = lw
		self.running = True

	def signalStop(self):
		self.running = False

	# Code runs when thread is executed
	def run(self):
		print(f"Starting processor thread {self.threadID}...")

		while self.running :
			flag = False
			doc = None

			#Acquire Lock and check queue
			self.ql.acquire()
			if not self.q.empty():
				doc = self.q.get()
				# Mark for processing
				flag = True
			self.ql.release()

			if flag:
				print(f'\033[1;32m  » Thread ID: {self.threadID} |\033[0m')
				# Check if word is a noun and/or originates from english
				nounFlag, engFlag, word, plural, wortartDescription, herkunftDescription = processDocument(doc)

				if nounFlag:
					print(f'\033[1;36m  » The word {word} is a noun\033[0m', end=' ')
					if engFlag:
						# acquire document stream lock and write
						self.dl.acquire()
						self.ds.write(f'{word},{plural},"{wortartDescription}","{herkunftDescription}"\n')
						self.ds.flush()
						os.fsync(self.ds.fileno())
						self.lw.seek(0)
						self.lw.write(word + '\t\n')
						self.lw.flush()
						os.fsync(self.lw.fileno())
						self.dl.release()
						print(f'\033[1;36mand comes from english. Plural: "{plural}". Saved into file!\033[0m')
						# print(f"\033[1;36m  » Thread ID: {self.threadID} | {word} saved!\033[0m")
					else:
						print('\033[1;33mbut it does not come from english. Word tossed.\033[0m')
						# print(f"\033[1;33m  » Thread ID: {self.threadID} | {word} do not comes from english \033[0m")
				else:
					print(f'\033[1;33m  » The word {word} is not a noun\033[0m')
			sleep(random())

		print(f"Exiting proccesing thread {self.threadID}...")