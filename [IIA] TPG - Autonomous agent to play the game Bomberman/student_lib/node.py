class Node:
    def __init__(self, pos, prev, dir, heuristic, cost):
        self.pos = pos
        self.prev = prev
        self.dir = dir
        self.heuristic = heuristic
        self.cost = cost
        self.evalfunc = heuristic + cost

    def __lt__(self, other):
        return self.evalfunc < other.evalfunc
