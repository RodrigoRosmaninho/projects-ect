import socket
import select
from _thread import *
from game_control import *
from certificate import validate_chain
import threading
import json, ast
import traceback
import hashlib
from OpenSSL import crypto as ssl_crypto
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.backends import default_backend
from datetime import date
import messages
import shuffle, crypto
from entities import Player
from time import sleep
from utils import Killable_Thread, UnexpectedMessageException
import sys, getopt


players = {}
pseudo_players = {}
new_player_lock = threading.Lock()
game_thr = None

rsa_priv_key = None

port = 12345
players_num = 2

tiles_per_pl = 7 if players_num<3 else 5
over = False
started = False
points_db = None
pseudo_db = None

ok = set()
deck = None
deck_ix = None
stock = None
stock_ix = None
cheated = False, None, None, None
initialHands = {}
pl_list = None
not_in_stock = []

cheating_penalty = 5

class GameEndedException(Exception):
    def __init__(self):
        super(GameEndedException, self).__init__("")

def game_thread():
    global deck, deck_ix, initialHands, pl_list, cheated, over, started

    try:
        while True:

            started = False
            if over:
                print("\nWaiting for game completion confirmation...")
                while len(ok) != len(players):
                    sleep(0.5)
                over = False

            while len(players) < players_num:
                sleep(0.5)

            print("[socket] All", players_num, "players have connected")

            reset_global_vars()

            pl_list=list(players.values())

            establish_client_sessions(pl_list)
            wait_for_ok(players_num)
            
            deck = shuffle.randomization(pl_list, tiles_per_pl)
            deck_ix = list(range(len(deck)))

            shuffle.selection(pl_list, deck_ix)

            wait_for_ok(players_num - 1)

            bitcommits = {}

            # Bit Commitment
            for ix,pl in enumerate(pl_list):
                pl.send({
                    'type': messages.COMMIT_REQUEST,
                    'stock': stock,
                    'deck': deck
                })


                while True:
                    data=pl.recv()

                    if data['type']!=messages.COMMIT_REPLY:
                        raise UnexpectedMessageException()

                    try:
                        pl.rsa_pub_key.verify(
                            bytes.fromhex(data['sig']),
                            hashlib.sha256(bytes.fromhex(data['commit'])).digest(),
                            padding.PSS(
                                mgf=padding.MGF1(hashes.SHA256()),
                                salt_length=padding.PSS.MAX_LENGTH),
                            hashes.SHA256())
                    except:
                        print("Ignored COMMIT_FORWARD with invalid signature")
                        continue
                    
                    break

                bitcommits[pl.name] = data['commit']
                for po in pl_list:
                    if po!=pl:
                        po.send({
                            'type': messages.COMMIT_FORWARD,
                            'player': ix,
                            'commit': data['commit'],
                            'sig': data['sig']
                        })
                print('Waiting')
                wait_for_ok(players_num-1)
                print("Waited")

            crypto.init(shuffle.iv)
            deck = [crypto.get_bytes(t) for t in deck]
            # Decryption
            for pl in reversed(pl_list):
                end=(pl==pl_list[0])

                pl.send({
                    'type': messages.REVELATION_REQUEST,
                    'end': end,
                    'reveal': True,
                    'keys': {}
                })

                data=pl.recv()

                if data['type']!=messages.REVELATION_REPLY:
                    raise UnexpectedMessageException()

                for crypt, key in data['keys'].items():
                    crypt=crypto.get_bytes(crypt)
                    key=crypto.get_bytes(key)
                    dec=crypto.decrypt(crypt,key)

                    try:
                        ix=deck.index(crypt)
                        if end:
                            dec = ast.literal_eval(dec.decode('utf-8'))
                            not_in_stock.append(dec)
                        deck[ix]=dec # client uses received keys to "decrypt" hand
                    except ValueError as e:
                        pass

                for po in pl_list:
                    if po!=pl:
                        po.send({
                            'type': messages.REVELATION_REQUEST,
                            'end': end,
                            'reveal': False,
                            'keys': data['keys']
                        })
                wait_for_ok(players_num-1)

                print(" --- Encryption layer from {} successfully removed\n".format(pl.name))

            shuffle.sendDeAnon(pl_list)

            wait_for_ok(players_num)

            print('[server] Deck distribution is finished')

            for i,t in enumerate(stock):
                stock[i]=crypto.get_bytes(t)

            game = GameFlow(pl_list, tiles_per_pl)
            started = True

            numPass = 0
            while True:
                p, action, sig = game.next_play()

                hand_inc = -1
                rec_tile = None
                if action['ac']=='pass':
                    hand_inc = 0
                    numPass += 1
                    if len(stock) > 0:
                        cheated = True, 'Server', pl_list[p].name, 'passing instead of drawing'
                        print("\n{} just tried to cheat by passing instead of performing a draw!".format(cheated[2]))
                        finalHands, points, cheaters = validateGame(pl_list, bitcommits, initialHands, game)
                        break
                elif action['ac']=='play':
                    numPass = 0
                    tileInStock = True
                    for deckElement in deck:
                        if len(deckElement) == 2:
                            if str(shuffle.tiles[deckElement[1]][1]) == str(action['tile']):
                                tileInStock = False
                                break
                    if tileInStock:
                        i=0
                        for pl in pl_list:
                            if i==p:
                                cheated = True, 'Server', pl.name, "playing a tile that didn't have"
                                break
                            i+=1
                        print("\n{} just tried to cheat by playing a tile that is still on the stock... Aborting game!".format(cheated[2]))
                        finalHands, points, cheaters = validateGame(pl_list, bitcommits, initialHands, game)
                        break
                elif action['ac']=='draw':
                    rec_tile = crypto.get_bytes(action['tile'])
                    if rec_tile not in stock: # includes empty stock detection
                        print("\n{} just tried to cheat by drawing a tile that is NOT on the stock... Aborting game!".format(cheated[2]))
                        finalHands, points, cheaters = validateGame(pl_list, bitcommits, initialHands, game)
                        break

                i=0
                for pl in pl_list:
                    if i!=p:
                        pl.send({
                            'type': messages.CONFIRM_ACTION,
                            'player': p,
                            'action': action,
                            'sig': sig
                        })
                    i+=1

                print("\nWaiting for confirmation by all players")
                wait_for_ok(players_num - 1)

                if cheated[0]:
                    print("\nCheating complain!")
                    finalHands, points, cheaters = validateGame(pl_list, bitcommits, initialHands, game)
                    break
                if rec_tile is not None:
                    pl_list[p].send({
                            'type': messages.OK
                        })
                    stock.remove(rec_tile)
                    new_tile = drawProcess(pl_list[p], rec_tile)
                    hand_inc = 1
                    game.state.play(Action({'ac':'draw', 'tile': new_tile},p))
                if game.execute_play(hand_inc):
                    break
                if numPass == players_num:
                    print("\nEveryone passed!")
                    break

            if not cheated[0]:
                print("\nGame finished successfully!")
                finalHands, points, cheaters = validateGame(pl_list, bitcommits, initialHands, game)

            points = countPoints(finalHands, points)
            print()
            for pl in pl_list:
                print("Player {} got {} points!".format(pl.name, points[pl.name]))
                pl.send({
                    'type': messages.POINTS_VALIDATION_REQUEST,
                    'final_hands': finalHands,
                    'points': points,
                    'cheaters': cheaters,
                    'penalty': cheating_penalty
                })
            wait_for_ok(players_num, False)
            for pl in pl_list:
                pl.send({
                    'type': messages.GAME_END,
                    'reason': 0,
                    'points': points[pl.name]
                })
                pl.points += points[pl.name]

            over = True
    except UnexpectedMessageException:
        print("\nUnexpected message received!\n-Game integrity is compromised.\n-Aborting")
    

def register_thread(c, addr):

    session_key = None
    pub_key = None
    while True:
        rec = b''
        while True:
            part = c.recv(1024)
            rec += part
            if len(part) < 1024:
                break
        try:
            data = json.loads(rec.decode('ascii'))
            mac = crypto.encrypt(hashlib.sha256(data['message'].encode('ascii')).digest(), session_key) if session_key is not None else None 
            if (mac.hex() if mac is not None else mac) != data['mac']:
                print("Ignored message with erroneous MAC")
                continue
            data = json.loads(data['message'])

            if data['type'] == messages.CONNECTION_REQUEST and pub_key is None:
                pub_key = serialization.load_pem_public_key(bytes.fromhex(data['key']), default_backend())
                a = crypto.dh_get_private()
                A = crypto.dh_get_public(a)
                c.send(json.dumps({
                    'message': json.dumps({
                        'type': messages.CONNECTION_REPLY,
                        'iv': crypto.get_string(shuffle.iv),
                        'param': A,
                        'sig': rsa_priv_key.sign(
                                    hashlib.sha256(str(A).encode('ascii')).digest(),
                                    padding.PSS(
                                        mgf=padding.MGF1(hashes.SHA256()),
                                        salt_length=padding.PSS.MAX_LENGTH),
                                    hashes.SHA256()).hex()
                    }),
                    'mac': None
                }).encode('ascii'))


            elif data['type'] == messages.CONNECTION_REPLY:
                pub_key.verify(
                    bytes.fromhex(data['sig']),
                    hashlib.sha256(str(data['param']).encode('ascii')).digest(),
                    padding.PSS(
                        mgf=padding.MGF1(hashes.SHA256()),
                        salt_length=padding.PSS.MAX_LENGTH),
                    hashes.SHA256())
                B = data['param']
                dh_sig = data['sig']
                session_key = crypto.dh_get_shared(a, B)

            elif data['type'] == messages.REGISTER_REQUEST and session_key is not None:
                p = Player(data['name'], bytes.fromhex(data['sig']), c, session_key, pub_key, B, dh_sig)
                accepted = p.name not in pseudo_db
                
                if accepted:
                    new_player_lock.acquire()
                    if len(players) < players_num:
                        players[c] = p
                        pseudo_players[data['name']] = p
                        print('[socket]', addr[0], ':', addr[1],'-', 'Registered, pseudonym:', data['name'])
                        pseudo_db.append(data['name'])
                        ok.add(p.name)
                    else:
                        c.close()
                        new_player_lock.release()
                        return
                    new_player_lock.release()

                p.send({
                    'type': messages.REGISTER_REPLY,
                    'accepted': accepted 
                })

                if accepted:
                    return

        except:
            c.close()
            return

def recv_thread():
    global stock, stock_ix, ok, cheated, initialHands, rsa_priv_key, over, game_thr
    host = "0.0.0.0"

    crypto.init(shuffle.iv)

    with open('rsa_private_key', 'rb') as kf:
        rsa_priv_key = serialization.load_pem_private_key(kf.read(), None, default_backend())

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((host, port))
    print("[socket] bound to port", port) 

    s.listen(5) 
    print("[socket] began listening")

    game_thr = Killable_Thread(target=game_thread)
    game_thr.start()


    while True:
        if len(players) < players_num:
            read_ready,_,_ = select.select([p.socket for p in players.values()] + [s], [], [], 1)
        else:
            read_ready,_,_ = select.select([p.socket for p in players.values()], [], [])

        for sock in read_ready:
            if sock is s and len(players) < players_num:
                c, addr = s.accept()
                print('[socket]', addr[0], ':', addr[1], '-', 'Connected')
                start_new_thread(register_thread, (c,addr,))
            else:
                try:
                    rec = b''
                    while True:
                        part = sock.recv(1024)
                        rec += part
                        if len(part) < 1024:
                            break

                    data = json.loads(rec.decode('ascii'))
                    mac = crypto.encrypt(hashlib.sha256(data['message'].encode('ascii')).digest(), players[sock].session_key)
                    if (mac.hex() if mac is not None else mac) != data['mac']:
                        print("Ignored message with erroneous MAC")
                        continue
                        
                    message = json.loads(data['message'])

                    if message['type'] == messages.ACTION_REPLY:
                        try:
                            players[sock].rsa_pub_key.verify(
                                bytes.fromhex(message['sig']),
                                hashlib.sha256(str(message['action']).encode('ascii')).digest(),
                                padding.PSS(
                                    mgf=padding.MGF1(hashes.SHA256()),
                                    salt_length=padding.PSS.MAX_LENGTH),
                                hashes.SHA256())
                        except:
                            print("Ignored ACTION_REPLY with invalid signature")
                            continue

                    print ("[socket]", players[sock].name, "sent message:", data)
                    
                    if message['type'] == messages.ROUTING:
                        if message['destination'] in pseudo_players:
                            dst = message['destination']
                            del message['destination']
                            message['source'] = players[sock].name
                            pseudo_players[dst].send(message)
                    elif message['type'] == messages.SELECTION_REPLY:
                        stock_ix = message['tiles']
                        stock = [deck[ix] for ix in stock_ix]
                        for player in players.values():
                            if players[sock] is not player:
                                player.send({
                                    'type': messages.SELECTION_END
                                })
                    elif message['type'] == messages.OK:
                        ok.add(players[sock].name)
                    elif message['type'] == messages.DE_ANON_PREP_REPLY:
                        shuffle.de_pseudonymize(list(players.values()), message['array'],deck_ix, deck, stock_ix)
                    elif message['type'] == messages.COMPLAIN:
                        if message['cheater'] is not None:
                            cheated = True, players[sock].name, message['cheater'], 'playing his own tile'
                        else:
                            raise GameEndedException()
                    elif message['type'] == messages.INITIAL_HAND_REPLY:
                        initialHands[players[sock].name] = message['initial_hand']
                    elif message['type'] == messages.CLAIM_POINTS_REQUEST:
                        try:
                            cert_pem = bytes.fromhex(message['certificate'])
                            certificate = ssl_crypto.load_certificate(ssl_crypto.FILETYPE_PEM, cert_pem)
                            x509_name = certificate.get_subject().get_components()
                            name = x509_name[len(x509_name) - 1][1].decode('ascii')
                            print("\nPlayer", players[sock].name, "is:", name)

                            pubKey_object = certificate.get_pubkey()
                            pubKeyString = ssl_crypto.dump_publickey(ssl_crypto.FILETYPE_PEM, pubKey_object)
                            pubKey = serialization.load_pem_public_key(pubKeyString, None)
                            pubKey.verify(players[sock].signature, bytes(players[sock].name, 'utf-8'), padding.PKCS1v15(), hashes.SHA1())
                            cert_date = date.today()
                            validate_chain(cert_pem, cert_date)
                            print('\nVerification succeeded - Player', players[sock].name)

                            points_db[name] = points_db[name] + players[sock].points if name in points_db else players[sock].points

                            players[sock].send({
                                'type': messages.CLAIM_POINTS_REPLY,
                                'name': name,
                                'points': points_db[name]
                            })

                        except:
                            print('\nVerification failed - Player', players[sock].name)
                            players[sock].send({
                                'type': messages.CLAIM_POINTS_REPLY,
                                'name': None,
                                'points': None
                            })

                        del players[sock]

                    else: 
                        players[sock].message = message
                        players[sock].lock.release()

                except json.decoder.JSONDecodeError:
                    print("\nClient unexpectedly disconnected. Restarting game")
                    kill_game(1, sock)

                except GameEndedException:
                    print("\nClient reported deck distribution / draw cheating. Restarting game")
                    kill_game(2, sock)

                except:
                    print('comms exception')
                    return

def wait_for_ok(num, checkCheaters = True):

    while len(ok) != num:
        if checkCheaters:
            if cheated[0]: #Client Complain received
                print("\n{} complained about player {}!".format(cheated[1], cheated[2]))
                break
            pass

    ok.clear()

def kill_game(reason, sock):
    global game_thr, over

    if not over:
        game_thr.kill()
        if reason == 1:
            del players[sock]

        for pl in players:
            players[pl].send({
                'type': messages.GAME_END,
                'reason': reason,
                'points': 0
            })
        over = True

        game_thr = Killable_Thread(target=game_thread)
        game_thr.start()

def wait_for_initial_hands(num):
    global initialHands

    while len(initialHands) != num:
        pass

def drawProcess(player, og_tile):
    print('\n   --- Player {} requested piece {} from the board ---'.format(player.name, og_tile))

    for pl in reversed(pl_list):
        end=(pl==pl_list[0])

        pl.send({
            'type': messages.REVELATION_REQUEST,
            'end': end,
            'reveal': True,
            'keys': {}
        })

        data=pl.recv()

        if data['type']!=messages.REVELATION_REPLY:
            raise UnexpectedMessageException()

        for crypt, key in data['keys'].items():
            crypt=crypto.get_bytes(crypt)
            key=crypto.get_bytes(key)
            dec=crypto.decrypt(crypt,key)

            try:
                ix=deck.index(crypt)
                if end:
                    dec = ast.literal_eval(dec.decode('utf-8'))
                    not_in_stock.append(dec)
                deck[ix]=dec
            except ValueError as e:
                pass

        for po in pl_list:
            if po!=pl:
                po.send({
                    'type': messages.REVELATION_REQUEST,
                    'end': end,
                    'reveal': False,
                    'keys': data['keys']
                })
        wait_for_ok(players_num-1)

    print('I got this pseudonym {}'.format(dec))


    player.send({
        'type': messages.DRAW_PREP
    })
    data = player.recv()
    if data['type']!=messages.DRAW_REQUEST:
        raise UnexpectedMessageException()
    new_tile = shuffle.de_pseudonymize_simple(player,dec,data['key'])
    
    for po in pl_list:
        if po!=player:
            po.send({
                'type': messages.DRAW_END,
            })
    wait_for_ok(players_num)

    print('   --- Draw process finished successfully ---\n')

    return new_tile

def validateGame(pl_list, initialBitcommits, data, game):
    gameRecap = GameFlow(pl_list, tiles_per_pl)
    points = {}
    cheaters = []
    print("\n\n--------------")
    print("| Game Recap |")
    print("--------------\n")

    for pl in pl_list:
        pl.send({
            'type': messages.INITIAL_HAND_REQUEST
        })
    print("Waiting for everyone's initial hand")
    wait_for_initial_hands(players_num)
    print("Got it! Sending data to everyone")
    for pl in pl_list:
        pl.send({
            'type': messages.COMMIT_VALIDATION_REQUEST,
            'initial_hands': initialHands,
            'cheating': cheated[0]
        })
    wait_for_ok(players_num, False)
    #Generate bit commitment from the data that originated the initial one
    finalBitcommits = {}
    for player, hand in data.items():
        dk = hashlib.sha256()
        for t in hand:
            dk.update(t.to_bytes(1,'big'))
        finalBitcommits[player]= dk.hexdigest()
        points[player] = 0

    #Compare both bit commitments
    for initPlayer, initCommit in initialBitcommits.items():
        for finalPlayer, finalCommit in finalBitcommits.items():
            if str(initPlayer) == str(finalPlayer):
                print("Comparing initial bit commitment with data sent from {}...".format(initPlayer), end=" ")
                if initCommit != finalCommit:
                    print("\nCHEATING - Could NOT validate {}'s bit commitment! Player sent wrong data".format(initPlayer))
                    #Punish player
                    if initPlayer not in cheaters:
                        points[initPlayer] -= cheating_penalty
                        cheaters.append(initPlayer)
                else:
                    print("Validated!".format(initPlayer))

    #Get initial hands from everyone
    print()
    for player, hand in data.items():
        for i, deckIndex in enumerate(hand):
            hand[i] = shuffle.tiles[deck[deckIndex][1]][1]
        print("Player {} had {} as initial tiles!".format(player, hand))

    #Verify the game log
    print()
    playerBefore = None
    actionBefore = None
    correctOrder = None
    for move in game.state.log:
        correctOrder = [i for i in range(len(pl_list))]
        if playerBefore is not None:
            if playerBefore == move.player and actionBefore == "draw":
                pass
            else:
                correctOrder = correctOrder[playerBefore:] + correctOrder[:playerBefore]
                for pl in correctOrder[1:]:
                    if move.player == pl:
                        break
                    else:
                        print("Pass by {} while having {}!".format(game.players[pl].name, data[game.players[pl].name]))
                        playable = False
                        for tile in data[game.players[pl].name]:
                            if gameRecap.state.validate_play(Action({'ac':'play', 'tile': tile, 'right': True}, game.players[pl]), False) or gameRecap.state.validate_play(Action({'ac':'play', 'tile': tile, 'right': False}, game.players[pl]), False) or len(stock) > 0:
                                playable = True
                                break
                        if playable:
                            print("CHEATING - {} could have either played a tile or draw, instead of passing!".format(game.players[pl].name))
                            #Punish player
                            if game.players[pl].name not in cheaters:
                                points[game.players[pl].name] -= cheating_penalty
                                cheaters.append(game.players[pl].name)

        if move.type == "play":
            gameRecap.state.play(Action({'ac':'play', 'tile': move.tile.id(), 'right': move.right},move.player))
            print("{} by {}: {} on the {} while having {}!".format(move.type.capitalize(), game.players[move.player].name, move.tile, "right" if move.right else "left", data[game.players[move.player].name]))
            print(gameRecap.state.board)
            if move.tile.id() in data[game.players[move.player].name]:
                data[game.players[move.player].name].remove(move.tile.id())
            else:
                print("CHEATING - {} did NOT have tile {} on this turn!".format(game.players[move.player].name, move.tile.id()))
                #Punish player
                if game.players[move.player].name not in cheaters:
                    points[game.players[move.player].name] -= cheating_penalty
                    cheaters.append(game.players[move.player].name)
        elif move.type == "draw":
            print("{} by {}: {} while having {}!".format(move.type.capitalize(), game.players[move.player].name, move.tile, data[game.players[move.player].name]))
            notInStock = False
            for hand in data.values():
                if move.tile.id() in hand:
                    notInStock = True
                    break
            if notInStock: # includes empty stock detection
                print("CHEATING - {} tried to draw tile {} even though it was NOT on the stock!".format(game.players[move.player].name, move.tile.id()))
                #Punish player
                if game.players[pl].name not in cheaters:
                    points[game.players[pl].name] -= cheating_penalty
                    cheaters.append(game.players[pl].name)
            else:
                data[game.players[move.player].name].append(move.tile.id())
        actionBefore = move.type
        playerBefore = move.player

    winner = None
    for pl in correctOrder:
        if len(data[game.players[pl].name]) == 0:
            winner = pl
            break

    if winner is not None:
        print("\nPlayer {} won the game!".format(game.players[winner].name))
    elif cheated[3] == 'passing instead of drawing':
        print("CHEATING - {} could have either played a tile or draw, instead of passing!".format(cheated[2]))
        #Punish player
        if cheated[2] not in cheaters:
            points[cheated[2]] -= cheating_penalty
            cheaters.append(cheated[2])
    elif not cheated[0]:
        for pl in correctOrder:
            print("Pass by {} while having {}!".format(game.players[pl].name, data[game.players[pl].name]))
            playable = False
            for tile in data[game.players[pl].name]:
                if gameRecap.state.validate_play(Action({'ac':'play', 'tile': tile, 'right': True}, game.players[pl]), False) or gameRecap.state.validate_play(Action({'ac':'play', 'tile': tile, 'right': False}, game.players[pl]), False) or len(stock) > 0:
                    playable = True
                    break
            if playable:
                print("CHEATING - {} could have either played a tile or draw, instead of passing!".format(game.players[pl].name))
                #Punish player
                if game.players[pl].name not in cheaters:
                    points[game.players[pl].name] -= cheating_penalty
                    cheaters.append(game.players[pl].name)
        print(gameRecap.state.board)
        print("\nEveryone Passed!!!")
        
    print("\nRecap concluded!")
    return data, points, cheaters

def countPoints(data, prevPoints):
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
        prevPoints[player] += points[player]
    prevPoints['total'] = totalPoints
    return prevPoints

def establish_client_sessions(players):
    clients = [pl.name for pl in players]
    params = [pl.dh_pub_key for pl in players]
    sigs = [pl.dh_sig for pl in players]
    keys = [pl.rsa_pub_key.public_bytes(serialization.Encoding.PEM, serialization.PublicFormat.PKCS1).hex() for pl in players]

    for player in players:
        player.send({
            'type': messages.DH_PROPAGATION,
            'clients': clients,
            'params': params,
            'keys': keys,
            'sigs': sigs
        })

def reset_global_vars():
    global deck, deck_ix, stock, stock_ix, cheated, initialHands, pl_list, not_in_stock

    ok.clear()
    deck = None
    deck_ix = None
    stock = None
    stock_ix = None
    cheated = False, None, None, None
    initialHands = {}
    pl_list = None
    not_in_stock = []


if __name__ == '__main__': 

    try:
        opts, args = getopt.getopt(sys.argv[1:],"p:n:",["port=", "num="])
    except getopt.GetoptError:
        print("Invalid input arguments!")
        print("Usage: python3 server.py -p <port> -n <players_num>")
        print("All arguments optional")
        sys.exit(1)

    for opt, arg in opts:
        if opt in ("-p", "--port"):
            port = int(arg)
        if opt in ("-n", "--num"):
            players_num = int(arg)

    print("Starting server... Configured for", str(players_num), "players per game")

    with open('points_db.json') as f:
        db = json.load(f)
        points_db = db['points']
        pseudo_db = db['pseudonyms']

        print("Current points_db state: ", end = "")
        if len(points_db) > 0:
            print()
            for name in points_db:
                print(name + ": " + str(points_db[name]) + " points")
        else:
            print("Empty")
        print()

    try:
        recv_thread()
    except KeyboardInterrupt:
        pass

    game_thr.kill()
    print("\nSaving points_db state...")
    with open('points_db.json', 'w') as f:
        json.dump({'points': points_db, 'pseudonyms': pseudo_db}, f)
    print("Closing")
