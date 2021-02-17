import random
import secrets
import crypto
import hashlib
import base64

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

from board import Domino
from utils import UnexpectedMessageException
import messages

tiles = [None for i in range(0,28)]

iv=crypto.get_iv()

salt = b'\x00'
def get_key():
    pwd=str(random.randint(00000,99999))
    kdf = PBKDF2HMAC(hashes.SHA1(),16,salt,1000,default_backend())
    key = kdf.derive(bytes(pwd,'UTF -8'))
    return key

def getTiles():
    t_list = []
    for i in range(0,7):
        for j in range(i, 7):
            t_list.append(Domino(i, j))
    return t_list

def h(i, Ki, Ti):
    dk = hashlib.sha256()
    dk.update(str(Ti.id()).encode('utf-8'))
    dk.update(Ki)
    #dk.update(i)
    #return base64.b64encode(dk.hexdigest().encode('ascii')).decode('ascii')
    return dk.hexdigest()

def pseudonymize(t_list):
    global tiles

    indices = [i for i in range(0,28)]
    s = secrets.SystemRandom()
    s.shuffle(indices)

    ret = [None for i in range(0,28)]
    for i in range(0,28):
        ix = indices[i]
        Ki = get_key()
        tiles[ix] = (Ki.hex(),t_list[i].id())
        ret[i] = (h(ix, Ki, t_list[i]), ix)

    s.shuffle(ret)
    return ret


def sendDeAnon(players):
    players[0].send({
        'type': messages.DE_ANON_PREP_REQUEST,
        'array': ['0' * 852 for i in range(0, 28)]
    })


def de_pseudonymize(players, keys, deck_ix, deck, stock_ix):
    cypher_lst = [None for i in range(0, 28)]

    for i in [ix for ix in deck_ix if ix not in stock_ix]:
        if keys[i] not in [None, '0' * 852]:
            pub_key = serialization.load_pem_public_key(bytes.fromhex(keys[i]), default_backend())
            cypher_lst[i] = pub_key.encrypt(str(list(tiles[deck[i][1]])).encode('utf-8'), padding.OAEP(padding.MGF1(hashes.SHA256()), hashes.SHA256(), None)).hex()

    for player in players:
        player.send({
            'type': messages.DE_ANON_REQUEST,
            'array': cypher_lst
        })

def de_pseudonymize_simple(player, pseudonym, key):
    pub_key = serialization.load_pem_public_key(bytes.fromhex(key), default_backend())
    
    tup = tiles[pseudonym[1]]
    ciphered = pub_key.encrypt(str(list(tup)).encode('utf-8'), padding.OAEP(padding.MGF1(hashes.SHA256()), hashes.SHA256(), None)).hex()

    player.send({
        'type': messages.DRAW_REPLY,
        'ciph': ciphered
    })

    return tup[1]

def randomization(players, tiles_per_pl):
    t_list = pseudonymize(getTiles())
    for player in players:
        player.send({
            'type': messages.RANDOMIZATION_REQUEST,
            'tiles': t_list,
            'tile_num': tiles_per_pl
        })
        message = player.recv()
        try:
            if message['type'] == messages.RANDOMIZATION_REPLY:
                t_list = message['tiles']
            else:
                raise UnexpectedMessageException()
        except:
            raise UnexpectedMessageException()
    return t_list
    
def selection(players, t_list):
    players[0].send({
        'type': messages.SELECTION_REQUEST,
        'tiles': t_list,
        'picked': []
    })
