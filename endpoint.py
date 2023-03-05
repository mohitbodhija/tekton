import requests
import json

url = "http://localhost:8080"

payload = json.dumps({
  "url": "https://raw.githubusercontent.com/mohitbodhija/sample/7f49b5ae10df407e4640c436fa39fe53f6a79f9a/my_tests.robot",
  "robot-file": "my_tests.robot"
})
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)
response = json.loads(response.text)
if (response['eventListenerUID']):
    print('tekton has been started')
