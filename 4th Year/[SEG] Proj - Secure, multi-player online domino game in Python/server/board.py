# Game Playing (useless)

import collections

# --- Domino Class ---

class Domino:

    def __init__(self,head,tail=None):
        if tail==None:
            tmp=head
            head=tmp//10
            tail=tmp%10
        self.head=head
        self.tail=tail

    def inv(self):
        return Domino(self.tail,self.head)

    def id(self):
        return min(self.head*10+self.tail, self.head+self.tail*10)

    def point(self):
        return self.head+self.tail

    def __str__(self):
        return '({}|{})'.format(self.head,self.tail)

# --- Board Class ---

class Board:

    def __init__(self):
        self.tiles = []

    # play validation
    def _valid_right(self,do):
        if self.tiles:
            return self.tiles[-1].tail==do.head or self.tiles[-1].tail==do.tail
        else:
            return True
    def _valid_left(self,do):
        if self.tiles:
            return self.tiles[0].head==do.head or self.tiles[0].head==do.tail
        else:
            return True
    def valid_play(self,do,right=True):
        if right:
            return self._valid_right(do)
        else:
            return self._valid_left(do)
    
    # insertion
    def _insert_right(self,do):
        if self.tiles:
            if self.tiles[-1].tail==do.head:
                self.tiles.append(do)
                return True
            elif self.tiles[-1].tail==do.tail:
                self.tiles.append(do.inv())
                return True
            else:
                return False
        else:
            self.tiles.append(do)
        return True
    def _insert_left(self,do):
        if self.tiles:
            if self.tiles[0].head==do.tail:
                self.tiles.insert(0,do)
                return True
            elif self.tiles[0].head==do.head:
                self.tiles.insert(0,do.inv())
                return True
            else:
                return False
        else:
            self.tiles.append(do)
        return True
    def insert(self,do,right=True):
        if right:
            return self._insert_right(do)
        else:
            return self._insert_left(do)
    
    def __str__(self):
        string = ""
        for d in self.tiles:
            string+=str(d)+" "
        return string


def test():
    board = Board()

    board.insert(Domino(3,4))
    board.insert(Domino(24))
    board.insert(Domino(1,3),False)

    print(board)

#test()