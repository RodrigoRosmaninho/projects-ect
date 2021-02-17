# Game Info

from board import *

# to be used for action logging
class Action:

    def __init__(self,dict,pl):
        self.player=pl
        self.type=None
        self.tile=None
        self.right=None
        if dict["ac"]=="play":
            self.type="play"
            self.tile=Domino(int(dict["tile"]))
            self.right=dict["right"]
        elif dict["ac"]=="pass":
            self.type="pass"
        elif dict['ac']=="draw":
            self.type="draw"
            self.tile=Domino(int(dict['tile']))

    def __str__(self):
        return '{}-{}-{}'.format(self.player,self.type,str(self.tile))


# game data (including history) to be held by every user
class GameState:

    def __init__(self,nplayers,tiles_per_player):
        self.log = [] # action log
        
        self.board = Board()
        
        self.turn = 0
        self.nplayers = nplayers
        self.tiles_per_player = []
        for i in range(self.nplayers):
            self.tiles_per_player.append(tiles_per_player)

    def validate_play(self,action,debug=True):
        valid = True
        # check log
        # check if already played
        for play in self.log:
            if play.type=='play' and str(action.tile) == str(play.tile):
                if debug:
                    print("Invalid Play! Someone already played tile", play.tile)
                return False

        valid=self.board.valid_play(action.tile,action.right)
        if not valid and debug:
            print("Invalid Play! Tile {} can't connect on the {} side of the board!".format(action.tile, "right" if action.right else "left"))
        return valid

    def play(self,action, debug = True):
        if action.type=='play':
            if not self.validate_play(action, debug):
                return False

            res=self.board.insert(action.tile,action.right)
        else:
            res=True

        if res:
            self.log.append(action)
        return res

    def whoPlayedTile(self, tile):
        for play in self.log:
            if str(tile) == str(play.tile.id()):
                return play.player
