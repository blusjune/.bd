#!/usr/bin/env python
#_ver=20130307_220020


import os, sys
#from pyinotify import WatchManager, Notifier, ProcessEvent, EventsCodes
import pyinotify


def Monitor(path):
#	mask = pyinotify.IN_ACCESS | pyinotify.IN_ATTRIB | pyinotify.IN_CLOSE_NOWRITE | pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | pyinotify.IN_DELETE_SELF | pyinotify.IN_DONT_FOLLOW | pyinotify.IN_IGNORED | pyinotify.IN_ISDIR | pyinotify.IN_MASK_ADD | pyinotify.IN_MODIFY | pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO | pyinotify.IN_MOVE_SELF | pyinotify.IN_ONESHOT | pyinotify.IN_ONLYDIR | pyinotify.IN_OPEN | pyinotify.IN_Q_OVERFLOW | pyinotify.IN_UNMOUNT
	mask = pyinotify.IN_ACCESS | pyinotify.IN_ATTRIB | pyinotify.IN_CLOSE_NOWRITE | pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | pyinotify.IN_DELETE_SELF | pyinotify.IN_ISDIR | pyinotify.IN_MODIFY | pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO | pyinotify.IN_MOVE_SELF | pyinotify.IN_OPEN | pyinotify.IN_UNMOUNT
	class PEvents(pyinotify.ProcessEvent):
		def process_IN_ACCESS(self, event):
			print "ACCESS: " + str(os.path.join(event.path, event.name))
		def process_IN_CLOSE(self, event):
			print "CLOSE: " + str(os.path.join(event.path, event.name))
		def process_IN_MODIFY(self, event):
			print "MODIFY: " + str(os.path.join(event.path, event.name))
		def process_IN_CREATE(self, event):
			print "CREATE: " + str(os.path.join(event.path, event.name))
		def process_IN_ISDIR(self, event):
			print "ISDIR: " + str(os.path.join(event.path, event.name))
		def process_IN_OPEN(self, event):
			print "OPEN: " + str(os.path.join(event.path, event.name))
		def process_IN_MOVED_FROM(self, event):
			print "MOVED_FROM: " + str(os.path.join(event.path, event.name))
		def process_IN_MOVED_TO(self, event):
			print "MOVED_TO: " + str(os.path.join(event.path, event.name))
		def process_IN_DELETE(self, event):
			print "DELETE: " + str(os.path.join(event.path, event.name))
	wm = pyinotify.WatchManager()
	wm.add_watch(path, mask)
	notifier = pyinotify.Notifier(wm, PEvents())

	try:
		while 1:
			notifier.process_events()
			if notifier.check_events():
				notifier.read_events()
	except KeyboardInterrupt:
		notifier.stop()
		return


if __name__ == '__main__':
	try:
		path = sys.argv[1]
	except IndexError:
		print 'use: %s dir' % sys.argv[0]
	else:
		Monitor(path)
