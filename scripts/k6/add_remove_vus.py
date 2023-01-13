import requests
import json
import sys

def usage():
    print("Usage: %s <add x> | <remove x>" % sys.argv[0])
    print("")
    sys.exit(1)

if len(sys.argv) < 3:
    usage()

try:
    vumod = int(sys.argv[2])
except:
    usage()

if sys.argv[1] == "remove":
    vumod = -vumod

r = requests.get("http://localhost:6565/v1/status")
status_response = r.json()
print(status_response)

vulevel = status_response['data']['attributes']['vus']
vumax = status_response['data']['attributes']['vus-max']

if vulevel + vumod < 0:
  print("Cannot decrease vus below 0")
  sys.exit(1)

if vulevel + vumod > vumax:
  print("Cannot increase vus above vus-max (currently set to: %d)" % vumax)
  sys.exit(1)

status_response['data']['attributes']['vus'] = vulevel + vumod
requests.patch("http://localhost:6565/v1/status", data=json.dumps(status_response))
r = requests.get("http://localhost:6565/v1/status")
print(r.json())
