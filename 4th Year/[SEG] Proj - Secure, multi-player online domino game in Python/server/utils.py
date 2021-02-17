import sys
import trace
import threading

class UnexpectedMessageException(Exception):
    def __init__(self):
        super(UnexpectedMessageException, self).__init__("")

class Killable_Thread(threading.Thread):
  def __init__(self, *args, **keywords):
    threading.Thread.__init__(self, *args, **keywords)
    self.kill_required = False

  def start(self):
    self.__run_super = self.run
    self.run = self.__run
    threading.Thread.start(self)

  def __run(self):
    sys.settrace(self.gtrace)
    self.__run_super()
    self.run = self.__run_super

  def gtrace(self, frame, why, arg):
    if why == 'call':
      return self.ltrace
    else:
      return None

  def ltrace(self, frame, why, arg):
    if self.kill_required:
      if why == 'line':
        raise SystemExit()
    return self.ltrace

  def kill(self):
    self.kill_required = True