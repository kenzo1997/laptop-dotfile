import curses
from math import log10, pow

# This is the window that displays the live VU level
class VUWindow:
    def __init__(self, stdscr):
        self.stdscr = stdscr
        self.resize()

    def resize(self):
        stdscr_height, stdscr_width = self.stdscr.getmaxyx()
        self.height = stdscr_height
        self.width = int(0.6 * stdscr_width)
        self.win = self.stdscr.subwin(self.height, self.width, 0, int(stdscr_width*0.4+0.5))
        self.win.bkgd(' ', curses.color_pair(1))
        self.chart_width = self.width - 12
        self.chart_height = self.height - 7

    def update(self, data):
        self.win.clear()
        self.win.box()
        # We can display chart_width # of data points - retrieve that many
        if len(data.vus) > self.chart_width:
            points = data.vus[-self.chart_width:]
        else:
            points = data.vus
        if len(points) < 1:
            return

        # Find largest sample value in the series, and first and last timestamp
        maxval = 0
        for point in points:
            t, val = point
            if val > maxval:
                maxval = val

        # Calculate an appropriate range and tick interval for the Y axis
        if maxval > 0:
            magnitude = int(pow(10, log10(maxval)))
            ymax = int(magnitude * int(maxval/magnitude) * 1.2)
        else:
            ymax = 1

        ytick = float(ymax) / 2.0
        # Calculate an appropriate tick interval for the X (time) axis
        xtick = (points[-1][0] - points[0][0]) / 3
        # Plot X and Y axis ticks
        self.win.addstr(1, 2, "VU")
        for i in range(3):
            ypos = 3 + self.chart_height - int( (float(self.chart_height)/2.0) * float(i) )
            s = str(int(i * ytick))
            self.win.addstr(ypos, 1 + 2-int(len(s)/2), s)
            self.win.addstr(ypos, 0, "-")

        # Plot the values
        for i in range(len(points)):
            bar_position = 7 + self.chart_width - len(points) + i
            t, val = points[i]
            bar_height = int(float(self.chart_height) * (float(val)/float(ymax)))
            self.win.vline(4 + self.chart_height - bar_height, bar_position, '#', bar_height)
            if i==0 or i==self.chart_width-1 or i==int((self.chart_width-1)/2):
                self.win.addstr(self.height-2, bar_position, "|")
                self.win.addstr(self.height-1, bar_position - 3, t.strftime("%H:%M:%S"))
            if i==len(points)-1:
                s = "%d VU" % val
                self.win.addstr(1 + self.chart_height - bar_height, bar_position - int(len(s)/2), s, curses.A_REVERSE)
                self.win.addstr(2 + self.chart_height - bar_height, bar_position, "|")
        self.win.noutrefresh()
