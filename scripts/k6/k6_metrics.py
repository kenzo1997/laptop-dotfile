import requests
import datetime
import json
from time import sleep

refresh_interval = 5
metrics = []

def main():
    global metrics, refresh_interval

    while True:
        metric_data = fetch()
        t = datetime.datetime.now()
        metrics.append( (t, metric_data) )

        if len(metrics) > 1:
            http_reqs = get_rate("http_reqs")
            iterations = get_rate("iterations")
            data_sent = get_rate("data_sent")
            data_received = get_rate("data_received")
            print("%s: reqs/s: %0.1f  Iterations/s: %0.1f  Bytes IN/s: %0.1f  Bytes OUT/s: %0.1f" % \
                                          ( datetime.datetime.now().strftime("%H:%M:%S"), http_reqs, iterations, data_received, data_sent ))

        sleep(refresh_interval)


def get_rate(metric_name):
    global metrics
    latest_fetch = metrics[-1][1]
    latest_timestamp = metrics[-1][0]
    previous_fetch = metrics[-2][1]
    previous_timestamp = metrics[-2][0]
    delta = latest_fetch[metric_name]['data']['attributes']['sample']['count'] - \
            previous_fetch[metric_name]['data']['attributes']['sample']['count']
    interval = metrics[-1][0] - metrics[-2][0]
    rate = float(delta) / float(interval.seconds)
    return rate

def fetch():
    r1 = requests.get("http://localhost:6565/v1/metrics/http_reqs").json()
    r2 = requests.get("http://localhost:6565/v1/metrics/iterations").json()
    r3 = requests.get("http://localhost:6565/v1/metrics/data_sent").json()
    r4 = requests.get("http://localhost:6565/v1/metrics/data_received").json()
    return { "http_reqs": r1, "iterations": r2, "data_sent": r3, "data_received": r4 }


if __name__ == "__main__":
    main()

