import requests

files = {'sample_upload': open('/home/eurico/maindoc.pdf', 'rb')}

url = 'http://127.0.0.1:10004/newSample'
r = requests.post(url, files=files)

print(r)
print(r.text)