
import messages
from game import *
from entities import *
from utils import UnexpectedMessageException

# class managing game progression (table manager only)
class GameFlow:
    def __init__(self,players,tiles_per_pl):
        self.players = players # player list
        self.state = GameState(len(players),tiles_per_pl)
        
        # experimental
        self.stock = None

    def next_play(self):
        turn = self.state.turn
        player = self.players[turn]

        print("\n|| PLAYER {} TURN ||".format(turn))

        print("Send Request to {}".format(player.name))

        while True:
            player.send({
                'type': messages.ACTION_REQUEST
            })

            move_msg=player.recv()
            if move_msg["type"]!=messages.ACTION_REPLY:
                raise UnexpectedMessageException()
            if move_msg['action']['ac']!="draw":
                action = Action(move_msg['action'],turn)

            if move_msg['action']['ac'] == 'pass' or move_msg['action']['ac'] == 'draw':
                break    
            if self.state.play(action):
                player.send({
                    'type': messages.OK
                })
                break
            # Invalid Play
            print("Invalid play! Please play a valid tile or pass your turn")

        return turn, move_msg['action'], move_msg['sig'] # flood to other players

    def execute_play(self, hand_inc=-1):
        turn = self.state.turn

        print("Board: "+str(self.state.board))

        self.state.tiles_per_player[turn]+=hand_inc
        if hand_inc==1:
            return False
        if self.state.tiles_per_player[turn]==0:
            print("\nPlayer {} wins!!".format(turn))
            return True

        self.state.turn=(self.state.turn+1) % self.state.nplayers
        return False
