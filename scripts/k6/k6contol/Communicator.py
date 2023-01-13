import datetime
import requests

# This thing handles communication with the running k6 instance
class Communicator:
    def __init__(self, k6_address):
        self.k6_address = k6_address
        self.status = []
        self.metrics = []
        self.vus = []

    def fetch_status(self):
        t = datetime.datetime.now()
        r = requests.get(self.k6_address + "/v1/status")
        data = r.json()['data']
        self.status.append((t, data))
        self.vus.append((t, data['attributes']['vus']))

    def fetch_metrics(self):
        t = datetime.datetime.now()
        r = requests.get(self.k6_address + "/v1/metrics")
        data = r.json()['data']
        self.metrics.append((t, data))

    def fetch_data(self):
        self.fetch_status()
        self.fetch_metrics()
