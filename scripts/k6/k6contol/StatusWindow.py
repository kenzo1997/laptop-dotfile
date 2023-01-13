import curses
from math import log10, pow

# This window displays general test information
class StatusWindow:
    def __init__(self, stdscr):
        self.stdscr = stdscr
        self.resize()

    def resize(self):
        stdscr_height, stdscr_width = self.stdscr.getmaxyx()
        self.height = stdscr_height // 2
        self.width = int(stdscr_width*0.4)
        self.win = self.stdscr.subwin(self.height, self.width, 0, 0)
        self.win.bkgd(' ', curses.color_pair(1))

    def update(self, data):
        self.win.clear()
        self.win.box()
        status = data.status[-1][1]['attributes']
        self.win.addstr(1, (self.width-14) // 2-1, "k6 test status")
        self.win.addstr(3, 2, "Running: ")
        self.win.addstr(3, 11, str(status['running']), curses.A_REVERSE)
        self.win.addstr(4, 2, " Paused: ")
        self.win.addstr(4, 11, str(status['paused']), curses.A_REVERSE)
        self.win.addstr(4, 17, "(P = toggle)")
        self.win.addstr(5, 2, "Tainted: ")
        self.win.addstr(5, 11, str(status['tainted']), curses.A_REVERSE)
        self.win.addstr(7, 2, "vus-max: %d" % status['vus-max'])
        self.win.addstr(8, 6, "vus: ")
        self.win.addstr(8, 11, str(status['vus']), curses.A_REVERSE)
        self.win.addstr(8, 16, "(+/- to change)")
        self.win.noutrefresh()
