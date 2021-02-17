from game import Action, GameState
import messages

class Logic:
    def __init__(self, numPlayers, tiles_per_player):
        self.gameState = GameState(numPlayers,tiles_per_player)

    def chooseValidTile(self, hand):
        if len(self.gameState.board.tiles)==0: #First play in the whole game
            return hand[0], True
        else:
            leftValue = self.gameState.board.tiles[0].head
            rightValue = self.gameState.board.tiles[-1].tail
            for tile in hand:
                if (tile>6):
                    leftTile = str(tile)[0]
                    rightTile = str(tile)[1]
                else:
                    leftTile = 0
                    rightTile = tile
                if int(leftTile) == int(rightValue): #Add no changed tile to the right side
                    return tile, True
                if int(rightTile) == int(leftValue): #Add no changed tile to the left side
                    return tile, False
                if int(rightTile) == int(rightValue): #Add flipped tile to the right side
                    return tile, True
                if int(leftTile) == int(leftValue): #Add flipped tile to the left side
                    return tile, False
        return None #No tile good enough was found  

    def chooseRandomTile(self):
        possible_tiles = [0,1,2,3,4,5,6,11,12,13,14,15,16,22,23,24,25,26,33,34,35,36,44,45,46,55,56,66]
        for index in possible_tiles:
            actDict = {
                'type': messages.ACTION_REPLY,
                'action': {
                    'ac': 'play',
                    'tile': possible_tiles[index],
                    'right': True
                }
            }
            if self.gameState.play(Action(actDict['action'], self.gameState.turn), False):
                return possible_tiles[index], actDict['action']['right']
            actDict['action']['right'] = False
            if self.gameState.play(Action(actDict['action'], self.gameState.turn), False):
                return possible_tiles[index], actDict['action']['right']

    def playTile(self, tile, bool): #Update the board with the last play
        actDict = {
            'type': messages.ACTION_REPLY,
            'action': {
                'ac': 'play',
                'tile': tile,
                'right': bool
            }
        }
        if not self.gameState.play(Action(actDict['action'],self.gameState.turn)):
            return False
        print(self.gameState.board)

        return 

    def playPass(self):
        actDict = {
            'type': messages.ACTION_REPLY,
            'action': {
                'ac': 'pass'
            }
        }
        print(self.gameState.board)

        return actDict

    def playDraw(self,tile):
        actDict = {
            'type': messages.ACTION_REPLY,
            'action': {
                'ac': 'draw',
                'tile': tile
            }
        }
        print(self.gameState.board)

        return actDict

    def duplicatedTile(self, hand):
        for boardTile in self.gameState.board.tiles:
            for handTile in hand:
                if str(boardTile.id()) == str(handTile):
                    return True, handTile, self.gameState.whoPlayedTile(handTile)
        return False, None

class Cheating:
    def cheatingWithRandomTile(self, game):
        cheatPlay = game.chooseRandomTile()

        actDict = {
            'type': messages.ACTION_REPLY,
            'action': {
                'ac': 'play',
                'tile': cheatPlay[0],
                'right': cheatPlay[1]
            }
        }
        print("Muahahahahahah I'm gonna cheat with", cheatPlay[0])
        print(game.gameState.board)

        return actDict

cheating=Cheating()

class Protesting:
    def checkForDuplicatedTiles(self, game, playerTiles, play_order):
        isDuplicated = game.duplicatedTile(playerTiles)
        if isDuplicated[0]: #Pos Validation error, proceeds to complain
            print("\nI want to protest!! Player {} duplicated tile {}!".format(play_order[isDuplicated[2]], isDuplicated[1]))
            return{
                    'type': messages.COMPLAIN,
                    'cheater': play_order[isDuplicated[2]]
            }
        else: #Pos Validation detected no cheating, send OK
            return{
                    'type': messages.OK
            }

protesting=Protesting()