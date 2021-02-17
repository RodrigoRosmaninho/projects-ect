import threading
import json
import hashlib

import crypto

class User:
    def __init__(self, name):
        self.name = name

class Player():
    def __init__(self, name, signature, socket, session_key, rsa_pub_key, dh_pub_key, dh_sig):
        self.name = name
        self.signature = signature
        self.socket = socket
        self.lock = threading.Lock()
        self.lock.acquire()
        self.message = None
        self.session_key = session_key
        self.rsa_pub_key = rsa_pub_key
        self.dh_pub_key = dh_pub_key
        self.points = 0
        self.dh_sig = dh_sig

    def send(self, message):
        payload = json.dumps(message)
        mac = crypto.encrypt(hashlib.sha256(payload.encode('ascii')).digest(), self.session_key).hex()
        self.socket.send(json.dumps({
            'message': payload,
            'mac': mac
        }).encode('ascii'))

    def recv(self):
        self.lock.acquire()
        return self.message
