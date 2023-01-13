# https://github.com/ragnarlonn/k6control
import sys
import time
import json
import getopt
import requests
import curses

from Communicator import Communicator
from VUWindow import VUWindow
from StatusWindow import StatusWindow
from MetricWindow import MetricsWindow

k6_url = "http://localhost:6565"
refresh_interval = 1
vumod = 1

def main():
    global k6_url, refresh_interval, vumod

    try:
        opts, args = getopt.getopt(sys.argv[1:], "iv:h", ["interval=","address=","vumod=","help"])
    except getopt.GetoptError as err:
        print(str(err))
        usage()
        sys.exit(1)

    for o, a in opts:
        if o in ("-i", "--interval"):
            try:
                refresh_interval = int(a)
            except:
                usage()
                sys.exit(1)
        elif o in ("-a", "--address"):
            k6_url = a
        elif o in ("-v", "--vumod"):
            try:
                vumod = int(a)
            except:
                usage()
                sys.exit(1)
        else:
            usage()
            if not o in ("-h", "--help"):
                sys.exit(1)
            sys.exit(0)

    # Execute the run() function via the curses wrapper
    curses.wrapper(run)

def run(stdscr):
    global k6_url, refresh_interval, vumod

    # Create a Communicator object that can talk to the running k6 instance
    k6 = Communicator(k6_url)

    # Init curses
    curses.start_color()
    curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)
    curses.curs_set(0)
    stdscr.nodelay(True)
    stdscr.clear()

    # Fetch some initial data from k6
    k6.fetch_data()
    last_fetch = time.time()
    start_time = last_fetch

    # Init onscreen curses windows
    vu_window = VUWindow(stdscr)
    status_window = StatusWindow(stdscr)
    metrics_window = MetricsWindow(stdscr)

    vu_window.update(k6)
    status_window.update(k6)
    metrics_window.update(k6)

    stdscr.refresh()
    update = False

    # Main loop
    while True:
        c = stdscr.getch()

        # 'Q' quits the program
        if c == ord('q') or c == ord('Q'):
            return
        if c == ord('p') or c == ord('P'):
            pause(k6)
            update = True
        if c == ord('+'):
            increaseVUS(k6)
            update = True
        if c == ord('-'):
            decreaseVUS(k6)
            update = True

        # Check for a terminal resize event and recalculate window sizes if there was one
        if c == curses.KEY_RESIZE:
            stdscr.erase()
            vu_window.resize()
            status_window.resize()
            metrics_window.resize()
            update = True

        # If new data has been fetched or terminal has been resized, recreate window contents
        if update:
            vu_window.update(k6)
            status_window.update(k6)
            metrics_window.update(k6)
            update = False

        # If it is time to fetch new data, do so and set update flag so window contents will be recreated
        if time.time() > (last_fetch + refresh_interval):
            k6.fetch_data() # this can take a bit of time = fairly likely a terminal resize event happens
            last_fetch = time.time()
            update = True # don't update windows immediately, in case terminal has been resized
        # Tell curses to update display, if necessary
        curses.doupdate()

def pause(k6):
    # PATCH back last status msg, with "paused" state inverted
    payload = {"data":k6.status[-1][1]}
    payload['data']['attributes']['paused'] = (not payload['data']['attributes']['paused'])
    r = requests.patch(k6_url + "/v1/status", data=json.dumps(payload))
    k6.fetch_status()

def increaseVUS(k6):
    # PATCH back last status msg, with "vus" increased
    payload = {"data":k6.status[-1][1]}
    payload['data']['attributes']['vus'] = payload['data']['attributes']['vus'] + vumod
    r = requests.patch(k6_url + "/v1/status", data=json.dumps(payload))
    k6.fetch_status()
    return True

def decreasedVUS(k6):
    # PATCH back last status msg, with "vus" decreased
    payload = {"data":k6.status[-1][1]}
    payload['data']['attributes']['vus'] = payload['data']['attributes']['vus'] - vumod
    r = requests.patch(k6_url + "/v1/status", data=json.dumps(payload))
    k6.fetch_status()

def usage():
     print("Usage: k6control [options]")
     print(" ")
     print(" Options:")
     print(" -a <k6_address> Specify where the running k6 instance")
     print(" --address=<k6_address> is that we want to control")
     print(" -i <seconds> How often should k6control refresh data")
     print(" --interval=<seconds> and plot new points in the VU graph")
     print(" -v <vus> How many VUs to add or remove when using")
     print(" --vumod=<vus> the +/- controls to add or remove VUs")
     print(" -h Show this help text")
     print(" --help")
     print("")

if __name__ == "__main__":
     main()

