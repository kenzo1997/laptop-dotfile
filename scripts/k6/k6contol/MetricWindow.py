import curses
from math import log10, pow

# This window displays general test information
class MetricsWindow:
    def __init__(self, stdscr):
        self.stdscr = stdscr
        self.resize()
    def resize(self):
        stdscr_height, stdscr_width = self.stdscr.getmaxyx()
        self.height = stdscr_height - (stdscr_height // 2)
        self.width = int(stdscr_width*0.4)
        self.win = self.stdscr.subwin(self.height, self.width, stdscr_height // 2, 0)
        self.win.bkgd(' ', curses.color_pair(1))
    def update(self, data):
        self.win.clear()
        self.win.box()
        self.win.addstr(1, (self.width-19) // 2-1, "Performance metrics")
        if len(data.metrics) > 2:
            metrics = [
                ( "iterations", "Iterations/s: ", 0),
                ( "data_received", "Bytes/s IN: ", 0),
                ( "data_sent", "Bytes/s OUT: ", 0),
                ( "http_reqs", "HTTP reqs/s: ", 0)
            ]

            interval = data.metrics[-1][0] - data.metrics[-3][0]
            for metric in data.metrics[-1][1]:
                for i, t in enumerate(metrics):
                    if metric['id'] == t[0]:
                        metrics[i] = (metrics[i][0], metrics[i][1], metric['attributes']['sample']['count'])

            for metric in data.metrics[-3][1]:
                for i, t in enumerate(metrics):
                    if metric['id'] == t[0]:
                        delta = t[2] - metric['attributes']['sample']['count']
                        rate = str(delta / interval.seconds)
                        self.win.addstr(3+i, 2, t[1])
                        self.win.addstr(3+i, 2 + len(t[1]), rate, curses.A_REVERSE)
        self.win.noutrefresh()

