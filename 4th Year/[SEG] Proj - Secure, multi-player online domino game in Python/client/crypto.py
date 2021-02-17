
import os, hashlib
from cryptography.hazmat.primitives import hashes, padding, serialization
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives.ciphers import Cipher,algorithms,modes
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from random import randint
import json, ast
import secrets

salt = b'\x00'
mode=None

# More Modular Exponential (MODP) Diffie-Hellman groups for Internet Key Exchange (IKE) - RFC 3526
# https://tools.ietf.org/html/rfc3526#page-3
# 2048-bit group - id 14
diffie_helman_consts = {
    'p': 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED529077096966D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2261898FA051015728E5A8AACAA68FFFFFFFFFFFFFFFF,
    'g': 2
}

rng = secrets.SystemRandom()

def get_iv():
    return os.urandom(algorithms.AES.block_size//8)

def init(iv):
    global mode
    mode=modes.OFB(iv)

def get_key():
    pwd=str(randint(00000,99999))

    kdf = PBKDF2HMAC(hashes.SHA1(),16,salt,1000,default_backend())
    key = kdf.derive(bytes(pwd,'UTF -8'))

    return key

def encrypt(cleartext,key):
    cipher=Cipher(algorithms.AES(key),mode,default_backend())
    encryptor=cipher.encryptor()

    ciphertext=encryptor.update(cleartext)+encryptor.finalize() # DO NOT ENCODE
    return ciphertext

def decrypt(ciphertext,key):
    cipher=Cipher(algorithms.AES(key),mode,default_backend())
    decryptor=cipher.decryptor()

    cleartext=decryptor.update(ciphertext)+decryptor.finalize()
    return cleartext # DO NOT DECODE

def get_string(by):
    return by.hex()

def get_bytes(st):
    return bytes.fromhex(st)

def dh_get_private():
    range_start = 10**(200-1)
    range_end = (10**200)-1
    return rng.randrange(range_start, range_end)

def dh_get_public(a):
    return pow(diffie_helman_consts['g'], a, diffie_helman_consts['p'])

def dh_get_shared(a, B):
    return hashlib.sha256(str(pow(B, a, diffie_helman_consts['p'])).encode('ascii')).digest()

def generate_RSA_keys():
    priv_key = rsa.generate_private_key(65537 ,2048 , default_backend())
    pub_key = priv_key.public_key()
    pub_key = pub_key.public_bytes(serialization.Encoding.PEM, serialization.PublicFormat.PKCS1)
    return priv_key, pub_key

def test():
    #arr = [[23,5],[46,5],[55,9],[14,4],[33,2]]
    clear = [23,7]

    keys = []

    cr = str(clear).encode('utf-8')
    data = {'bytes': cr.hex()}
    print(data['bytes'])
    js = json.dumps(data)
    for i in range(4):
        cr = bytes.fromhex(json.loads(js)['bytes'])
        
        print("\n--Encrypt {}".format(cr))
        key=get_key()
        print('Key {}'.format(key))
        keys.append(key)
        cr=encrypt(cr,key)
        print('Bytes {}'.format(cr))
        print('Length {}'.format(len(cr)))
        
        data = {'bytes': cr.hex()}
        js = json.dumps(data)

    for i in range(4):
        cr = bytes.fromhex(json.loads(js)['bytes'])

        print("\n--Decrypt {}".format(cr))
        key=keys.pop(-1)
        print('Key {}'.format(key))
        cr=decrypt(cr,key)
        print('Bytes {}'.format(cr))

        data = {'bytes': cr.hex()}
        js = json.dumps(data)

    cr = bytes.fromhex(json.loads(js)['bytes'])
    
    cr=cr.decode('utf-8')
    print(cr)
    print(ast.literal_eval(cr)[0])

    # for i in arr:
    #     print("\n--Encrypt {}".format(i))
    #     key=get_key()
    #     ciph=encrypt(str(i).encode(),key)
    #     print(ciph)
    #     print(decrypt(ciph,key).decode())

#test()