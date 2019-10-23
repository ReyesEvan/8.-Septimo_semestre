# from timeit                     import timeit
# from time                       import time
import time
from random                     import random
from queue						import Queue
from threading 					import Lock, Thread
import re
import os

from AdvancedHTMLParser 		import AdvancedHTMLParser


def processDocument(title, herkunft):
	#print(type(title))
	#print(type(herkunft))

	# Check if herkunft exists in order to verify if it comes from english
	word = title[0].getElementsByClassName('lemma__main')[0].innerHTML.translate({0x00AD: None})
	if not herkunft is None:
		# print(herkunft.outerHTML)
		header = re.search('<p *>.*englisch.*</p>', herkunft.outerHTML)
		if header :
			print(title[0].getElementsByClassName('lemma__main')[0].innerHTML)
			return True, word
	# 	return True, word
	# return False, word
	return False, word




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
				# title, herkunft = self.q.get()
				doc = self.q.get()

				# Mark for processing
				flag = True
			self.ql.release()

			if flag:
				# split doc into required components
				title = doc.getElementsByClassName('lemma__title')
				herkunft = doc.getElementById('herkunft')
				#print(title[0].outerHTML)
				#print(herkunft.outerHTML)
				# Check if word originates from english
				engFlag, word = processDocument(title, herkunft)

				if engFlag:
					# acquire document stream lock and write
					self.dl.acquire()
					self.ds.write(word + '\n')
					self.ds.flush()
					os.fsync(self.ds.fileno())
					self.lw.seek(0)
					self.lw.write(word + '\t\n')
					self.lw.flush()
					os.fsync(self.lw.fileno())
					self.dl.release()
					print(f"\033[1;36m  » Thread ID: {self.threadID} | {word} saved!\033[0m")
				else:
					print(f"\033[1;33m  » Thread ID: {self.threadID} | {word} does not comes from english \033[0m")

			# TODO: Decide on a sleep time
			time.sleep(random())



		print(f"Exiting proccesing thread {self.threadID}...")





# class dThread (Thread):
#
# 	running = True
#
# 	# Thread, Identifier, docstream, streamlock
# 	def __init__(self, threadID, ds, sl):
# 		threading.Thread.__init__(self)
# 		self.threadID = threadID
# 		running = True
#
# 	def signalStop():
# 		running = False
#
# 	# Code runs when thread is executed
# 	def run(self):
# 		print(f"Starting writer thread {self.threadID}")
# 		flag = False
#
# 		while running :
#
# 			#Acquire Lock and check queue
# 			l.acquire()
# 			if not q.empty():
# 				document = q.get()
# 				flag = True
# 			l.release()
#
# 			if flag:
# 				# process the document
# 				pass
#
# 			# TODO: Decide on a sleep time
# 			flag = False
# 			sleep(random())
#
#
# 		print(f"Exiting proccesing thread {self.threadID}")
