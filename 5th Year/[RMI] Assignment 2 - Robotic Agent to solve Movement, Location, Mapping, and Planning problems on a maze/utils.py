import heapq
from enum import Enum
import math
import itertools

diameter = 2
initial_pos = None

CELLROWS=7
CELLCOLS=14

class Direction(Enum):
    UP = 90
    RIGHT = 0
    DOWN = -90
    LEFT = 180


rev_dict = {
        Direction.RIGHT: (1, 0, Direction.LEFT), 
        Direction.DOWN: (0, -1, Direction.UP), 
        Direction.LEFT: (-1, 0, Direction.RIGHT), 
        Direction.UP: (0, 1, Direction.DOWN)
    }
class Node:
    def __init__(self, cell, prev, dir, heuristic, cost):
        self.cell = cell
        self.prev = prev
        self.dir = dir
        self.heuristic = heuristic
        self.cost = cost
        self.evalfunc = heuristic + cost

    def __lt__(self, other):
        return self.evalfunc < other.evalfunc

class Cell:
    def __init__(self, pos, up, right, down, left, visited):
        self.pos = pos
        self.up = up
        self.right = right
        self.down = down
        self.left = left
        self.visited = visited
        self.measurements = [[], [], [], []]
        self.beacon = -1

    def __str__(self):
        return "<CELL " + str(self.pos) + " " + ("?" if self.up is None else ("T" if self.up else "F"))  + ("?" if self.right is None else ("T" if self.right else "F")) + ("?" if self.down is None else ("T" if self.down else "F")) + ("?" if self.left is None else ("T" if self.left else "F")) + ("V" if self.visited else "~V") + ">"

    def __repr__(self):
        return str(self)


# Manhattan distance between two points
def distance(p1, p2):
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

# convert sensor value to distance to obstacle
def sensor_to_dist(sensor):
        return 1/sensor if sensor > 0 else 5 # note sensors have about 0.05 error when there's a wall, otherwise, they're buggy a hell


# Get a path between two points using the A* algorithm
def get_path(map, start, target):
    dict = {}
    q = []
    root = Node(start, None, None, distance(start.pos, target), 0)
    heapq.heappush(q, (root.evalfunc, root))
    
    while len(q) > 0:

        evalfunc, current = heapq.heappop(q)

        for (dir, cell) in get_possible_next_nodes(map, current.cell):

            cost = current.cost + 1

            already_seen = cell in dict
            if not already_seen or (already_seen and cost < dict[cell].cost):
                node = Node(cell, current, dir, distance(cell.pos, target), cost)
                if node.cell.pos == target:
                    return reconstruct_path(node)
                dict[cell] = node
                if (node.evalfunc, node) not in q:
                    heapq.heappush(q, (node.evalfunc, node))

    return None

# Reconstruct path to a given node (using Node class prev field)
def reconstruct_path(target):
    path = []
    current = target
    while current.prev is not None:
        path.insert(0, (current.dir, current.cell))
        current = current.prev
    return path


# Get list of free nodes that neighbor a given node
def get_possible_next_nodes(map, cell):
    list = []
    for (d, x, y) in [(Direction.RIGHT, 1, 0), (Direction.DOWN, 0, -1), (Direction.LEFT, -1, 0), (Direction.UP, 0, 1)]:
        try:
            candidate_cell = cell_at_pos(map, (cell.pos[0] + x, cell.pos[1] + y))
            wall = getattr(cell, d.name.lower())
            if candidate_cell is not None and wall is not None and not wall:
                list.append((d, candidate_cell))
        except IndexError:
            pass
    return list

# Ensure that the irSensor measurement list is always [UP, RIGHT, DOWN, LEFT] regardless of current robot orientation
def get_compass_adjusted_measurements(irSensor, compass):
    measurements = [None, None, None, None]
    adjustment = round(compass/90)
    measurements[(0 - adjustment) % 4] = irSensor[1] # Left Sensor 
    measurements[(1 - adjustment) % 4] = irSensor[0] # Center Sensor 
    measurements[(2 - adjustment) % 4] = irSensor[2] # Right Sensor 
    measurements[(3 - adjustment) % 4] = irSensor[3] # Back Sensor 
    return measurements

def gps_to_relative(x, y):
    return ((x - initial_pos[0]) / diameter, (y - initial_pos[1]) / diameter)

def relative_to_grid(rel):
    return (rel[0] + 13, rel[1] + 6)

def grid_to_relative(grd):
    return (grd[0] - 13, grd[1] - 6)

def cell_at_pos(map, pos):
    try:
        pos = relative_to_grid(pos)
        return map[pos[1]][pos[0]]
    except IndexError:
        return None

def is_improper(cell):
    return cell is None or not any([f == False for f in [cell.up, cell.right, cell.down, cell.left]])

def build_map(map):
    corner = (0,0)
    for row in map:
        for cell in row:
            if not is_improper(cell):
                corner = cell.pos if (cell.pos[0] < corner[0]) or (cell.pos[1] > corner[1]) else corner

    #for y in range(corner[1], 7 + corner[1]):
    #    for x in range(corner[0], 14 + corner[0]):

    print(corner, end="\n\n")

    top_offset = ((-1 * corner[1]) + 6) * 2
    right_offset = abs((corner[0]) * 2)
    bottom_offset = abs((corner[1]) * 2)
    left_offset = (corner[0] + 13) * 2

    string = ((" " * (29 + left_offset + right_offset)) + "\n") * top_offset

    for y in range(0,-15,-1):
        for x in range(0, 14):
            pos = (x + corner[0], math.ceil(y/2) + corner[1])

            if y % 2 == 0:
                top = cell_at_pos(map, (pos[0], pos[1] + 1))
                bot = cell_at_pos(map, (pos[0], pos[1]))

                #print(bot)

                if x == 0:
                    string += (" " * (left_offset + 1))
                string += "- " if (not is_improper(top) and top.down == True) or (not is_improper(bot) and bot.up == True) else ("X " if not is_improper(top) and not is_improper(bot) else "  ")
            else:
                left = cell_at_pos(map, (pos[0], pos[1]))
                right = cell_at_pos(map, (pos[0] + 1, pos[1])) 

                if x == 0:
                    string += (" " * left_offset) + ("|" if not is_improper(left) else " ")
                
                string += (str(left.beacon) if left.beacon != -1 else "X") if not is_improper(left) else " "
                string += "|" if (not is_improper(left) and left.right == True) or (not is_improper(right) and right.left == True) else ("X" if not is_improper(left) and not is_improper(right) else " ")
        string += (" " * right_offset) + "\n"

    string += ((" " * (29 + left_offset + right_offset)) + "\n") * bottom_offset

    return string

def get_adjacent_cells(cell,angle):
    dirs = [(cell.right, (1, 0), "left"), (cell.up, (0, 1), "down"), (cell.left, (-1, 0), "right"), (cell.down, (0, -1), "up")]
    phase = round(angle/90)
    if phase < 0:
        phase += 4
    # right: [left, down, up, right]
    # up: [down, right, left, up]
    # left: [right, up, down, left]
    # down: [up, left, right, down]
    return [dirs[phase%4], dirs[(phase+2)%4], dirs[(phase+3)%4], dirs[(phase+1)%4]]

def eval_beacon_path(map, beacons, max_beacons):
    if len(beacons) < max_beacons:
        return (False, None)

    actual = get_beacon_path(map, beacons, max_beacons)

    speculative_map = [[None for col in range(CELLCOLS*2-1)] for row in range(CELLROWS*2-1)]
    for row in range(len(map)):
        for cell in range(len(map[row])):
            if map[row][cell] is None:
                c = Cell(grid_to_relative((cell, row)), False, False, False, False, False)
            else:
                ac = map[row][cell]
                c = Cell(grid_to_relative((cell, row)), False if ac.up is None else ac.up, False if ac.right is None else ac.right, False if ac.down is None else ac.down, False if ac.left is None else ac.left, False)
            speculative_map[row][cell] = c

    best_case = get_beacon_path(speculative_map, beacons, max_beacons)

    if best_case[1] < actual[1]:
        return (False, actual)
    else:
        return (True, actual)

    

def get_beacon_path(map, beacons, max_beacons):
    paths = {}

    for i in range(0, len(beacons)):
        for j in range(i+1, len(beacons)):
            paths[(i,j)] = get_path(map, beacons[i], beacons[j].pos)

    perms = list(beacons.keys())
    perms.remove(0)
    perms = itertools.permutations(perms)
    best = (None, math.inf, [])
    for p in perms:
        p = list(p)
        p.insert(0,0)
        p.append(0)
        path = []
        for b in range(1, len(p)):
            tpath = paths[tuple(sorted([p[b-1], p[b]]))]
            #print(tpath)
            if p[b-1] > p[b]:
                tpath.pop()
                tpath.reverse()
                tpath.append((None, beacons[p[b]]))
            #print(tpath)
            path += tpath

        if len(path) < best[1]:
            best = (p,len(path),path)

    res = pos_to_output(beacons[0].pos) + "\n"
    for d, c in best[2]:
        res += pos_to_output(c.pos) + ((" #" + str(c.beacon)) if c.beacon not in [-1,0] else "") + "\n"

    best = (best[0], best[1], res)
    return best

    
def pos_to_output(pos):
    return str(pos[0]*2) + " " + str(pos[1]*2)
