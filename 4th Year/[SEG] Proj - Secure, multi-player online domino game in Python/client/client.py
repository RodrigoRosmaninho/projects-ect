import socket 
import random
import hashlib
import json
import secrets
import base64
import ast
import messages
from gameLogic import Logic
from random import seed
from random import randint
from random import shuffle
import sys, getopt
from gameLogic import Logic, cheating, protesting
from game import Domino
import secrets
import crypto
import messages
import traceback
import cryptography.x509 as x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives.asymmetric import utils
from cryptography.hazmat.primitives.serialization import load_der_public_key
from cryptography.hazmat.primitives.serialization import Encoding
from os import path
try:
    from PyKCS11 import *
    from PyKCS11.LowLevel import *
except Exception as e:
    print('Could not import PyKCS11: %s'%(e))

s = None
rsa_priv = None
rsa_pub = None

cryptokeys = {} # Ci: Ki
bitcommits = {}
selfcommit = None
pseudonym = None

addr = "127.0.0.1"
port = 12345
test = False

play_order = None

server_pub_key = None

server_session_key = None
client_keysbin = None

prob_select_end = 50
prob_pick_tile = 50
prob_swap_tiles = 50
prob_end_deanon = 50
prob_add_keys = 50
prob_cheat = 100
prob_deck_cheating = 0

class GameEndedException(Exception):
    def __init__(self, reason, points):
        super(GameEndedException, self).__init__("")
        self.points = points
        self.reason = reason

class UnexpectedMessageException(Exception):
    def __init__(self):
        super(UnexpectedMessageException, self).__init__("")

def send(message):
    if message['type'] == messages.ROUTING:
        message['data'] = crypto.get_string(crypto.encrypt(json.dumps(message['data']).encode('ascii'), client_keys[message['destination']]['dh']))

    elif message['type'] == messages.ACTION_REPLY:
        message['sig'] = rsa_priv.sign(
            hashlib.sha256(str(message['action']).encode('ascii')).digest(),
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH),
            hashes.SHA256()).hex()

    payload = json.dumps(message)
    mac = crypto.encrypt(hashlib.sha256(payload.encode('ascii')).digest(), server_session_key).hex() if server_session_key is not None else None
    s.send(json.dumps({
        'message': payload,
        'mac': mac
    }).encode('ascii'))


def receive(prt=False):
    while True:
        try:
            rec = b''
            while True:
                part = s.recv(1024)
                rec += part
                if len(part) < 1024:
                    break
            decode = rec.decode('ascii')
            if prt:
                if len(decode)>3145:
                    print(decode[3135:3145])
                print("RECEIVE: {}".format(decode))
            
            data = json.loads(decode)
            mac = crypto.encrypt(hashlib.sha256(data['message'].encode('ascii')).digest(), server_session_key) if server_session_key is not None else None
            if (mac.hex() if mac is not None else mac) != data['mac']:
                print("Ignored message with erroneous MAC")
                continue

            data['message'] = json.loads(data['message'])

            try:
                if data['message']['type'] == messages.ROUTING:
                    data['message']['data'] = json.loads(crypto.decrypt(crypto.get_bytes(data['message']['data']), client_keys[data['message']['source']]['dh']))
                    test = data['message']['data']['type']
            except:
                print("Ignored routing message that could not be decrypted or had malformed payload after decryption")
                continue

            try:
                if data['message']['type'] == messages.CONFIRM_ACTION:
                    client_keys[play_order[data['message']['player']]]['rsa'].verify(
                        bytes.fromhex(data['message']['sig']),
                        hashlib.sha256(str(data['message']['action']).encode('ascii')).digest(),
                        padding.PSS(
                            mgf=padding.MGF1(hashes.SHA256()),
                            salt_length=padding.PSS.MAX_LENGTH),
                        hashes.SHA256())
            except:
                print("Ignored CONFIRM_ACTION with invalid signature")
                continue

            try:
                if data['message']['type'] == messages.COMMIT_FORWARD:
                    client_keys[play_order[data['message']['player']]]['rsa'].verify(
                        bytes.fromhex(data['message']['sig']),
                        hashlib.sha256(bytes.fromhex(data['message']['commit'])).digest(),
                        padding.PSS(
                            mgf=padding.MGF1(hashes.SHA256()),
                            salt_length=padding.PSS.MAX_LENGTH),
                        hashes.SHA256())
            except:
                print("Ignored COMMIT_FORWARD with invalid signature")
                continue

            try:
                if data['message']['type'] == messages.DH_PROPAGATION:
                    for i in range(len(data['message']['sigs'])):
                        key = serialization.load_pem_public_key(bytes.fromhex(data['message']['keys'][i]), default_backend())
                        key.verify(
                            bytes.fromhex(data['message']['sigs'][i]),
                            hashlib.sha256(str(data['message']['params'][i]).encode("ascii")).digest(),
                            padding.PSS(
                                mgf=padding.MGF1(hashes.SHA256()),
                                salt_length=padding.PSS.MAX_LENGTH),
                            hashes.SHA256())
            except:
                print("Ignored DH_PROPAGATION with invalid signature")
                continuehost
            if data['message']['type'] == messages.GAME_END and data['message']['reason'] != 0:
                raise GameEndedException(data['message']['reason'], data['message']['points'])

            return data['message']

        except KeyError:
            print('Ignored message with incomplete data')
            continue

def h(Ki, Ti):
    dk = hashlib.sha256()
    dk.update(str(Ti).encode('utf-8'))
    dk.update(bytes.fromhex(Ki))
    return dk.hexdigest()

def commit(hand):
    dk = hashlib.sha256()
    for t in hand:
        dk.update(t.to_bytes(1,'big'))
    return dk.hexdigest()

def Main(): 
    global cryptokeys, bitcommits, selfcommit, pseudonym, server_session_key, client_keys, server_pub_key, play_order

    with open('server_public_key', 'rb') as kf:
        server_pub_key = serialization.load_pem_public_key(kf.read(), default_backend())
    
    global s 
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM) 

    try:
        s.connect((addr,port))
    except ConnectionRefusedError:
        print("Error! The server is not online!")
        return

    server_session_key, iv, dh_a = server_handshake()
    crypto.init(crypto.get_bytes(iv))
    
    signature = b''
    cert_pem = b''
    if not test:
        pkcs11 = PyKCS11.PyKCS11Lib()
        if path.exists("/usr/local/lib/libpteidpkcs11.so"):
            pkcs11.load('/usr/local/lib/libpteidpkcs11.so')
        else:
            pkcs11.load('/usr/lib/libpteidpkcs11.so')
        slots = pkcs11.getSlotList()

        found_cc = False
        for slot in slots:
            if 'CARTAO DE CIDADAO' in pkcs11.getTokenInfo(slot).label:
                found_cc = True
                session = pkcs11.openSession(slot)

                privKey = session.findObjects([(CKA_CLASS, CKO_PRIVATE_KEY), (CKA_LABEL, 'CITIZEN AUTHENTICATION KEY')])[0]

                certificate = session.findObjects(template=[(PyKCS11.CKA_LABEL, "CITIZEN AUTHENTICATION CERTIFICATE"), (PyKCS11.CKA_CLASS, PyKCS11.CKO_CERTIFICATE)])[0]
            
                all_attr = [e for e in list(PyKCS11.CKA.keys()) if isinstance(e, int)]
                attr = session.getAttributeValue(certificate, all_attr)
                attr = dict(zip(map(PyKCS11.CKA.get, all_attr), attr))
                
                cert_der = x509.load_der_x509_certificate(bytes(attr['CKA_VALUE']), default_backend())
                cert_pem = cert_der.public_bytes(Encoding.PEM)

                while True:
                    pseudonym = 'steve'+str(randint(00000000, 99999999))
                    send({
                        'type': messages.REGISTER_REQUEST,
                        'sig': bytes(session.sign(privKey, bytes(pseudonym, 'utf-8'), Mechanism(CKM_SHA1_RSA_PKCS))).hex(),
                        'name': pseudonym
                    })
                    data = receive()
                    if data['type'] != messages.REGISTER_REPLY:
                        raise UnexpectedMessageException()
                    if data['accepted']:
                        break

                session.closeSession()

        if not found_cc:
            print("\nNo citizenship card connected")
            return

    # If Test mode is enabled
    else:
        while True:
            pseudonym = 'steve'+str(randint(00000000, 99999999))
            send({
                'type': messages.REGISTER_REQUEST,
                'sig': signature.hex(),
                'name': pseudonym
            })
            data = receive()
            if data['type'] != messages.REGISTER_REPLY:
                raise UnexpectedMessageException()
            if data['accepted']:
                break   

    print("Hi I am {}".format(pseudonym))

    while True:
        try:
            print("Starting new game...")

            cryptokeys = {} # Ci: Ki
            bitcommits = {}
            selfcommit = None
            client_keys = None

            play_order, client_keys = clients_handshake(dh_a) 
            numPlayers = len(play_order)

            data = receive()
            
            if data['type'] != messages.RANDOMIZATION_REQUEST:
                raise UnexpectedMessageException()

            # --- ENCRYPTION/RANDOMIZATION

            new_tiles=[]
            for i,tile in enumerate(data['tiles']):
                if not isinstance(tile,str):
                    tile=crypto.get_string(str(tile).encode('utf-8'))
                
                btile=crypto.get_bytes(tile)
                collision = True
                key = None
                while collision:
                    key=crypto.get_key()
                    cr=crypto.encrypt(btile,key)
                    collision = cr in cryptokeys

                cryptokeys[cr]=key

                data['tiles'][i]=crypto.get_string(cr)


            secret_s = secrets.SystemRandom()
            secret_s.shuffle(data['tiles'])

            hand_size = data['tile_num']

            final_stocksize = len(data['tiles']) - numPlayers * hand_size

            next_player = play_order[(play_order.index(pseudonym) +1) % numPlayers]

            players_without_self = play_order.copy()
            players_without_self.pop(players_without_self.index(pseudonym))

            randomization_reply = {
                'type': messages.RANDOMIZATION_REPLY,
                'tiles': data['tiles']
            }

            send(randomization_reply)

            pseudo_hand = []

            data = receive()
            
            setup = True
            
            # --- SELECTION

            while setup:
                if data['type'] != messages.ROUTING and data['type'] != messages.SELECTION_REQUEST  and data['type'] != messages.SELECTION_END:
                    raise UnexpectedMessageException()
                else:
                    if data['type'] == messages.SELECTION_END:
                        if len(pseudo_hand) < hand_size:
                            print("\nSelection ended before hand was complete. Deck distribution cheating occured!")
                            send({
                                'type': messages.COMPLAIN,
                                'cheater': None
                            })
                            data = receive()
                        else:
                            setup = False
                            send({
                                'type': messages.OK
                            })
                            break
                    else:
                        tiles = []
                        picked = []
                        if data['type'] == messages.ROUTING:
                            if data['data']['type'] != messages.SELECTION_REPLY:
                                raise UnexpectedMessageException()
                            tiles = data['data']['tiles']
                            picked = data['data']['picked']
                        else:
                            tiles = data['tiles']
                            picked  = data['picked']

                        if len(tiles) == final_stocksize or (randint(0,99) < prob_deck_cheating and randint(0,99) < 50): # second randint servers to have even smaller probability
                            action = randint(0, 99)
                            if(action < prob_select_end):
                                setup = False
                                selection_end = {
                                    'type': messages.SELECTION_REPLY,
                                    'tiles': tiles,
                                    'picked': picked
                                }
                                send(selection_end)
                                break

                        action = randint(0, 99)
                        if action < prob_pick_tile and len(pseudo_hand) < hand_size:
                            tile_choice = randint(0, len(tiles)-1)
                            pic_tile = tiles.pop(tile_choice)
                            pseudo_hand.append(pic_tile)
                            picked.append(pic_tile)
                        else:
                            action = randint(0, 99)
                            if action < prob_swap_tiles and len(pseudo_hand) > 0:
                                number_of_swaps = randint(1,len(pseudo_hand))
                                for i in range(number_of_swaps):
                                    tile_choice = randint(0, len(tiles)-1)
                                    temp_tile = pseudo_hand.pop(i)
                                    picked.remove(temp_tile)
                                    pic_tile = tiles.pop(tile_choice)
                                    pseudo_hand.insert(i, pic_tile)
                                    picked.append(pic_tile)
                                    tiles.insert(tile_choice, temp_tile)

                        player_selection = randint(0, len(players_without_self)-1)

                        selection_reply = {
                            'type': messages.ROUTING,
                            'destination': players_without_self[player_selection],
                            'data': {
                                'type': messages.SELECTION_REPLY,
                                'tiles': tiles,
                                'picked': picked
                            }
                        }            
                        send(selection_reply)
                data=receive()

            # --- COMMIT

            index_hand = pseudo_hand.copy()
            while len(bitcommits)<numPlayers:
                data=receive()

                if data['type']==messages.COMMIT_REQUEST:
                    selfcommit=commit(pseudo_hand)
                    send({
                        'type': messages.COMMIT_REPLY,
                        'commit': selfcommit,
                        'sig': rsa_priv.sign(
                                    hashlib.sha256(bytes.fromhex(selfcommit)).digest(),
                                    padding.PSS(
                                        mgf=padding.MGF1(hashes.SHA256()),
                                        salt_length=padding.PSS.MAX_LENGTH),
                                    hashes.SHA256()).hex()
                                    })
                    stock=data['stock']
                    pseudo_hand = [crypto.get_bytes(data['deck'][t_ix]) for t_ix in pseudo_hand]
                    bitcommits[str(pseudonym)] = None #self commit
                    print("Sent my bit commitment {}".format(selfcommit))
                elif data['type']==messages.COMMIT_FORWARD:
                    bitcommits[play_order[data['player']]] = data['commit']
                    print("Received bit commitment {} from player {}".format(data['commit'],play_order[data['player']]))
                    send({
                        'type': messages.OK
                    })
                else:
                    raise UnexpectedMessageException()
            
            for i,t in enumerate(stock):
                stock[i]=crypto.get_bytes(t)

            # --- DECRYPTION

            new_crypts={}
            while True:
                data=receive()

                if data['type']!=messages.REVELATION_REQUEST:
                    raise UnexpectedMessageException()

                if data['reveal']:
                    to_send={}
                    for tile,key in cryptokeys.items():
                        if (new_crypts!={} and tile in new_crypts.values()) or (new_crypts=={} and tile not in stock): # if first to decrypt, tile not in stock, else new_crypts has stuff in it
                            t_str=crypto.get_string(tile)
                            k_str=crypto.get_string(key)
                            to_send[t_str]=k_str
                    for i,tile in enumerate(pseudo_hand):
                        dec=crypto.decrypt(tile,cryptokeys[tile])
                        pseudo_hand[i]=dec

                    
                    send({
                        'type': messages.REVELATION_REPLY,
                        'keys': to_send
                    })
                else:
                    new_crypts={}
                    for crypt, key in data['keys'].items():
                        crypt=crypto.get_bytes(crypt)
                        key=crypto.get_bytes(key)
                        dec=crypto.decrypt(crypt,key)
                        new_crypts[crypt]=dec

                        try:
                            ix=pseudo_hand.index(crypt)
                            pseudo_hand[ix]=dec # client uses received keys to "decrypt" hand
                        except ValueError as e:
                            pass

                    send({
                        'type': messages.OK
                    })

                if data['end']:
                    break

            pseudo_hand=[ast.literal_eval(t.decode('utf-8')) for t in pseudo_hand]

            # --- DE-ANON

            de_anon = True

            my_private_keys = []

            #missing_keys = [t[1] for t in pseudo_hand]
            missing_keys = index_hand.copy()

            while de_anon:
                data = receive()
                if data['type'] == messages.DE_ANON_REQUEST:
                    break
                elif data['type'] != messages.ROUTING and data['type'] != messages.DE_ANON_PREP_REQUEST:
                    raise UnexpectedMessageException()
                else:
                    key_array = []
                    if data['type'] == messages.ROUTING:
                        if data['data']['type'] != messages.DE_ANON_PREP_REPLY:
                            raise UnexpectedMessageException()
                        key_array = data['data']['array']
                    else:
                        key_array = data['array']
                    

                    if key_array.count('0' * 852) <= final_stocksize:
                        action = randint(0,99)
                        if action < prob_end_deanon:
                            selection_reply = {
                                'type': messages.DE_ANON_PREP_REPLY,
                                'array': key_array
                            }            
                            send(selection_reply)
                            continue
                    
                    action = randint(0, 99)
                    if action < prob_add_keys and len(missing_keys) > 0:
                        key_choice = randint(0, len(missing_keys)-1)
                        chosen_key = missing_keys.pop(key_choice)
                        key_array.pop(chosen_key)
                        priv_key, pub_key = crypto.generate_RSA_keys()
                        my_private_keys.append([chosen_key, priv_key])
                        key_array.insert(chosen_key, pub_key.hex())

                    cheating_key = randint(0,27)
                    if randint(0,99) < prob_deck_cheating and cheating_key not in ([a[0] for a in my_private_keys] + missing_keys):
                        priv_key, pub_key = crypto.generate_RSA_keys()
                        key_array.pop(cheating_key)
                        key_array.insert(cheating_key, pub_key.hex())
                        
                    player_selection = randint(0, len(players_without_self)-1)
                    selection_reply = {
                            'type': messages.ROUTING,
                            'destination': players_without_self[player_selection],
                            'data': {
                                'type': messages.DE_ANON_PREP_REPLY,
                                'array': key_array
                            }
                        }            
                    send(selection_reply)

            if data['type'] != messages.DE_ANON_REQUEST:
                raise UnexpectedMessageException()

            encrypted_deck = data['array']
            current_hand = [] 
            ki_values = []

            try:
                for i in range(len(my_private_keys)):
                    tmp = ast.literal_eval(my_private_keys[i][1].decrypt(bytes.fromhex(encrypted_deck[my_private_keys[i][0]]), padding.OAEP(padding.MGF1(hashes.SHA256()), hashes.SHA256(), None)).decode('utf-8'))
                    ki_values.append(tmp[0])
                    current_hand.append(tmp[1])

                # Verify hand
                for i in range(len(current_hand)):
                    try:
                        pseudo = h(ki_values[i], current_hand[i])
                    except:
                        ValueError()
                    
                    if pseudo not in [a[0] for a in pseudo_hand]:
                        raise ValueError()
                        

            except ValueError:
                print("\nCould not de-anonimize deck. Deck distribution cheating occured!")
                send({
                    'type': messages.COMPLAIN,
                    'cheater': None
                })
                data = receive()

            send({
                    'type': messages.OK
                })

            game = Logic(numPlayers,hand_size)
            drawing = False
            drawn_tile = None
            stock_empty = len(stock)<=0
            option = 0
            while True: 
                data = receive()
                if data['type'] == messages.CONFIRM_ACTION: #Send OK, opponent played
                    if data['action']['ac']=='draw':
                        rec_tile = crypto.get_bytes(data['action']['tile'])
                        send({
                                'type': messages.OK
                            })
                        stock.remove(rec_tile)
                        drawProcess(False, rec_tile)
                        stock_empty = len(stock)<=0
                    else:
                        print("Opponent",play_order[data['player']],"played", str(data['action']['tile'])+"!") if data['action']['ac'] == 'play' else print ("Opponent",play_order[data['player']],"passed!")
                        game.playTile(data['action']['tile'], data['action']['right']) if data['action']['ac'] == 'play' else game.playPass()
                        send(protesting.checkForDuplicatedTiles(game, current_hand, play_order)) #Pos Validation
                elif data['type'] == messages.ACTION_REQUEST: #Send ACTION_REPLY, this client played
                    print("I'm playing with current hand:", current_hand)
                    tileToPlay = game.chooseValidTile(current_hand)
                    if tileToPlay==None:
                        cheating_chance = randint(0,99)
                        if cheating_chance < prob_cheat: #Cheating chance = 20%
                            send(cheating.cheatingWithRandomTile(game))
                        elif not stock_empty:
                            if False and cheating_chance < prob_cheat:
                                print("Fake Pass like Ronaldinho Gaúcho")
                                send(game.playPass())
                            else:
                                print("No valid play found, gib tile")
                                print(len(stock)-1)
                                tile_choice = randint(0, len(stock)-1)
                                drawn_tile = stock.pop(tile_choice)
                                send(game.playDraw(crypto.get_string(drawn_tile)))
                                drawing = True
                        else:
                            print("Passing...")
                            send(game.playPass())
                    else:
                        send({
                                'type': messages.ACTION_REPLY,
                                'action': {
                                    'ac': 'play',
                                    'tile': tileToPlay[0],
                                    'right': tileToPlay[1]
                                }
                            })          
                elif data['type'] == messages.OK:
                    if drawing: #This client requested a piece from stock, once all players validate his request, they will enter draw process
                        new_tile=drawProcess(True, drawn_tile)
                        current_hand.append(new_tile)
                        drawing = False
                        draw_tile = None
                        stock_empty = len(stock)<=0
                        #stock_empty = True #for testing purposes
                    elif tileToPlay != None: #This client's play validated, removing tile
                        game.playTile(tileToPlay[0], tileToPlay[1])
                        current_hand.remove(tileToPlay[0])
                elif data['type'] == messages.INITIAL_HAND_REQUEST: #Someone complained about cheating!!
                    send({
                        'type': messages.INITIAL_HAND_REPLY,
                        'initial_hand': index_hand
                    })
                elif data['type'] == messages.COMMIT_VALIDATION_REQUEST: #Comparison between initial and final bit commits
                    print("\n\nGame {}! Proceeding to validate everyone's bit commitments for the game recap.\n".format(
                        "aborted because there was a suspicion of cheating" if data['cheating'] else "finished successfully"))
                    #Generate bit commitment from the data that originated the initial one
                    finalBitcommits = {}
                    for player, hand in data['initial_hands'].items():
                        if str(player) == str(pseudonym):
                            continue
                        dk = hashlib.sha256()
                        for t in hand:
                            dk.update(t.to_bytes(1,'big'))
                        finalBitcommits[player]= dk.hexdigest()
                    #Compare both bit commitments
                    for initPlayer, initCommit in bitcommits.items():
                        for finalPlayer, finalCommit in finalBitcommits.items():
                            if str(initPlayer) == str(pseudonym):
                                continue
                            if str(initPlayer) == str(finalPlayer):
                                print("Comparing initial bit commitment with data sent from {}...".format(initPlayer), end=" ")
                                if initCommit != finalCommit:
                                    print("\nCould NOT validate {}'s bit commitment! Player sent wrong data".format(initPlayer))
                                    #Punish player
                                else:
                                    print("Validated!".format(initPlayer))
                    send({
                            'type': messages.OK
                        })
                elif data['type'] == messages.POINTS_VALIDATION_REQUEST:
                    print()
                    clientPoints = countPoints(data['final_hands'], data['cheaters'], data['penalty'])
                    for player in clientPoints.keys():
                        print("Comparing server's score for {}...".format(player), end=" ")
                        if data['points'][player] != clientPoints[player]:
                            print("\nCould NOT validate {}'s points!".format(initPlayer))
                        else:
                            print("Validated!".format(initPlayer))
                    send({
                            'type': messages.OK
                        })
                elif data['type'] == messages.GAME_END:
                    option = get_end_option(0, data['points'])
                    break

        except GameEndedException as gee:
            option = get_end_option(gee.reason, gee.points)
            
        if option == 2:
            claim_points = {
                'type': messages.CLAIM_POINTS_REQUEST,
                'certificate': cert_pem.hex()
            }

            send(claim_points)

            data = receive()

            if data['type'] != messages.CLAIM_POINTS_REPLY:
                raise UnexpectedMessageException()

            print("\nVerification " + (("confirmed.\nYou are " + data['name'] + " and have a total of " + str(data['points']) + " points.") if data['points'] is not None else "failed."))
            print("Closing")

            # close the connection 
            s.close()
            return

        send({
            "type": messages.OK
        })
        print()

def get_end_option(reason, points):
    option = 0
    while int(option) not in [1,2]:
        try:
            option = int(input("\n\nGame has ended" + (" due to the unexpected disconnection of another player" if reason==1 else (" due to deck distribution / draw cheating" if reason == 2 else "")) + ".\nReceived " + str(points) + " points\nSelect option:\n[1] - Play again\n[2] - Cash in points and leave\n"))
        except KeyboardInterrupt:
            raise KeyboardInterrupt()
        except:
            option = 0
            continue
    return option

def server_handshake():
    global rsa_priv, rsa_pub

    a = crypto.dh_get_private()
    rsa_priv, rsa_pub = crypto.generate_RSA_keys()
    send({
        'type': messages.CONNECTION_REQUEST,
        'key': rsa_pub.hex()
    })

    response = receive()
    if response['type'] != messages.CONNECTION_REPLY:
        raise UnexpectedMessageException()
    
    server_pub_key.verify(
        bytes.fromhex(response['sig']),
        hashlib.sha256(str(response['param']).encode('ascii')).digest(),
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256())

    A = crypto.dh_get_public(a)
    send({
        'type': messages.CONNECTION_REPLY,
        'param': A,
        'sig': rsa_priv.sign(
                    hashlib.sha256(str(A).encode('ascii')).digest(),
                    padding.PSS(
                        mgf=padding.MGF1(hashes.SHA256()),
                        salt_length=padding.PSS.MAX_LENGTH),
                    hashes.SHA256()).hex()
    })

    return crypto.dh_get_shared(a, response['param']), response['iv'], a

def clients_handshake(a):
    global rsa_priv, rsa_pub

    data = receive()
    if data['type'] != messages.DH_PROPAGATION:
        raise UnexpectedMessageException()

    clients = data['clients']    

    res = clients, {clients[i]:{'dh': crypto.dh_get_shared(a, data['params'][i]), 'rsa': serialization.load_pem_public_key(bytes.fromhex(data['keys'][i]), default_backend())} for i in range(len(clients)) if clients[i] != pseudonym}

    send({
        'type': messages.OK
    })

    return res

def drawProcess(mine, og_tile):
    if mine:
        print('\n   --- I requested piece {} from the board ---'.format(og_tile))
    else:
        print('\n   --- Someone requested piece {} from the board ---'.format(og_tile))

    tile = og_tile
    # --- DECRYPTION
    while True:
        data=receive()

        if data['type']!=messages.REVELATION_REQUEST:
            raise UnexpectedMessageException()

        if data['reveal']:
            key_pair = {}

            key=cryptokeys[tile]
            t_str=crypto.get_string(tile)
            k_str=crypto.get_string(key)
            key_pair[t_str]=k_str
            
            send({
                'type': messages.REVELATION_REPLY,
                'keys': key_pair
            })
        else:
            tile = list(data['keys'])[0]
            key = data['keys'][tile]

            tile=crypto.get_bytes(tile)
            key=crypto.get_bytes(key)

            send({
                'type': messages.OK
            })
        tile=crypto.decrypt(tile,key)

        if data['end']:
            break

    print('I got this pseudonym {}'.format(tile))

    if mine:
        data=receive()
        if data['type']!=messages.DRAW_PREP:
            raise UnexpectedMessageException()
        priv_key, pub_key = crypto.generate_RSA_keys()
        send({
            'type': messages.DRAW_REQUEST,
            'key': pub_key.hex()
        })

        data=receive()
        if data['type']!=messages.DRAW_REPLY:
            raise UnexpectedMessageException()
        
        try:
            tmp = ast.literal_eval(priv_key.decrypt(bytes.fromhex(data['ciph']), padding.OAEP(padding.MGF1(hashes.SHA256()), hashes.SHA256(), None)).decode('utf-8'))
            ki = tmp[0]
            new_tile = tmp[1]
            # Verify
            try:
                pseudo = h(ki, new_tile)
                tile = ast.literal_eval(tile.decode('utf-8'))[0]
            except:
                raise ValueError()
            
            if pseudo != tile:
                raise ValueError()

        except ValueError:
            print("\nCould not de-anonimize draw. Draw cheating occured!")
            send({
                'type': messages.COMPLAIN,
                'cheater': None
            })
            data = receive()

        print('The resulting tile is {}'.format(new_tile))

        send({
            'type': messages.OK
        })

        print('   --- Draw process finished successfully ---\n')

        return new_tile

    data=receive()
    if data['type']!=messages.DRAW_END:
        raise UnexpectedMessageException()

    send({
        'type': messages.OK
    })

    print('   --- Draw process finished successfully ---\n')
    return None

def countPoints(data, cheaters, penalty):
    points = {}
    totalPoints = 0
    for player, hand in data.items():
        points[player] = 0
        for tileID in hand:
            tile = Domino(tileID)
            points[player] += tile.point()   
        totalPoints += points[player]
    for player in points.keys():
        points[player] = totalPoints - points[player]
        if player in cheaters:
            points[player] -= penalty
    points['total'] = totalPoints
    return points

if __name__ == '__main__':

    try:
        opts, args = getopt.getopt(sys.argv[1:],"ta:p:",["addr=","port="])
    except getopt.GetoptError:
        print("Invalid input arguments!")
        print("Usage: python3 client.py -a <address> -p <port> -t")
        print("All arguments optional")
        sys.exit(1)

    for opt, arg in opts:
      if opt == '-t':
        test = True
      elif opt in ("-a", "--addr"):
        addr = arg
      elif opt in ("-p", "--port"):
        port = int(arg)

    try:
        Main()
    except json.decoder.JSONDecodeError:
        print("\nServer unexpectedly disconnected!")
    except KeyboardInterrupt:
        print("\nClosing")
    except UnexpectedMessageException:
        print("\nUnexpected message received!\n-Game integrity is compromised.\n-Aborting")