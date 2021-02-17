import heapq, random
from student_lib.node import Node
from student_lib.consts import Direction
from student_lib import consts


# Manhattan distance between two points
def distance(p1, p2):
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])


# Get a path between two points using the A* algorithm
def get_path(map, state, start, target, enemy_directions, powerups, exact=False, use_in_range=False, avoid_exit=False,
             force_all_nodes=False):
    dict = {}
    q = []
    root = Node(start, None, None, distance(start, target), 0)
    heapq.heappush(q, (root.evalfunc, root))
    number_of_nodes = 0
    closest_to_target = root

    while len(q) > 0:

        current = heapq.heappop(q)

        if not force_all_nodes and number_of_nodes > consts.MAX_SEARCH_NODES:
            return closest_to_target

        number_of_nodes += 1

        for pos in get_possible_next_nodes(map, state, current[1].pos, enemy_directions, 3, use_in_range, False, False,
                                           powerups, False, 2, avoid_exit):

            cost = current[1].cost + 1

            already_seen = repr(pos[1]) in dict
            if not already_seen or (already_seen and cost < dict[repr(pos[1])].cost):
                node = Node(pos[1], current[1], pos[0], distance(pos[1], target), cost)
                if node.pos == target and node.pos not in state['walls']:
                    return reconstruct_path(node)
                elif (not exact) and node.heuristic <= 1 and node.pos not in state['walls']:
                    return reconstruct_path(node)
                dict[repr(pos[1])] = node
                if node.heuristic < closest_to_target.heuristic:
                    closest_to_target = node
                if (node.evalfunc, node) not in q:
                    heapq.heappush(q, (node.evalfunc, node))

    return closest_to_target


# Reconstruct path to a given node (using Node class prev field)
def reconstruct_path(target):
    path = []
    current = target
    while current.prev is not None:
        path.insert(0, (current.dir, current.pos))
        current = current.prev
    return path


# Get list of free nodes that neighbor a given node
def get_possible_next_nodes(map, state, p1, enemy_directions, range, use_in_range=False, ignore_destructibles=False,
                            use_bomb_range=False, powerups=None, in_evade=False, normal_range=2, avoid_exit=False):
    list = []
    for (d, x, y) in [(Direction.RIGHT, 1, 0), (Direction.DOWN, 0, 1), (Direction.LEFT, -1, 0), (Direction.UP, 0, -1)]:
        if check_if_can_move(map, state, [p1[0] + x, p1[1] + y], enemy_directions, range, use_in_range,
                             ignore_destructibles, use_bomb_range, powerups, in_evade, normal_range, avoid_exit):
            list.append((d, ([p1[0] + x, p1[1] + y])))
    return list


# Get bomberman's closest wall
def get_closest_wall(map, state, blocked_walls=None, blocked_target=None):
    if blocked_walls is None:
        blocked_walls = []
    length = len(state['walls'])
    if length == 0:
        return None
    if length == 1:
        return state['walls'][0]
    if length == len(blocked_walls):
        return None

    use_target = blocked_target is not None and 'pos' in blocked_target

    bomberman = state['bomberman']
    closest = None, float("inf")
    for wall in [w for w in state['walls'] if w not in blocked_walls]:
        dist = distance(bomberman, wall)
        if use_target:
            dist = (dist * 0.15) + distance(blocked_target['pos'], wall)
        if dist < closest[1]:
            closest = wall, dist

    if closest[0] is None:
        return closest

    # Determine if the wall is blocked on all sides
    possible_vectors = get_possible_next_nodes(map, state, closest[0], None, 1, False, False, False, None, False, 2,
                                               False)
    if len(possible_vectors) > 0:
        return closest[0]
    else:
        blocked_walls.append(closest[0])
        return get_closest_wall(map, state, blocked_walls)


# Get farthest wall from a given enemy
def get_far_wall(map, state, enemy, blocked_walls=None):
    if blocked_walls is None:
        blocked_walls = []
    length = len(state['walls'])
    if length == 0:
        return None
    if length == 1:
        return state['walls'][0]
    if length == len(blocked_walls):
        return None

    farthest = None, -1
    for wall in [w for w in state['walls'] if w not in blocked_walls]:
        dist = distance(enemy, wall)
        if dist > farthest[1]:
            farthest = wall, dist

    if farthest[0] is None:
        return farthest

    # Determine if the wall is blocked on all sides
    possible_vectors = get_possible_next_nodes(map, state, farthest[0], None, 1, False, False, False, None, False, 2,
                                               False)
    if len(possible_vectors) > 0:
        return farthest[0]
    else:
        blocked_walls.append(farthest[0])
        return get_far_wall(map, state, enemy, blocked_walls)


# Get closest enemy to bomberman's position
def get_closest_enemy(map, state, enemies, powerups=None, blocked_enemies=None):
    if blocked_enemies is None:
        blocked_enemies = []
    length = len(enemies)
    if length == 0:
        return None
    if length == 1:
        return enemies[0], distance(state['bomberman'], enemies[0]['pos'])

    bomberman = state['bomberman']
    closest = None, float("inf")
    for enemy in enemies:
        if enemy['pos'] not in blocked_enemies or length == len(blocked_enemies):
            dist = distance(bomberman, enemy['pos'])
            if dist < closest[1]:
                closest = enemy, dist

    if closest[0] is None:
        return closest

    # Determine if enemy is blocked on all sides
    possible_vectors = get_possible_next_nodes(map, state, closest[0]['pos'], None, 1, False, False, False, powerups,
                                               False,
                                               2, False)
    if len(possible_vectors) > 0 or length == len(blocked_enemies):
        return closest
    else:
        blocked_enemies.append(closest[0]['pos'])
        return get_closest_enemy(map, state, enemies, powerups, blocked_enemies)


# Get closest enemy to a given position
def get_closest_enemy_from_pos(state, pos, enemies):
    length = len(enemies)
    if length == 0:
        return None
    if length == 1:
        return enemies[0], distance(pos, enemies[0]['pos'])
    closest = None, float("inf")
    for enemy in enemies:
        dist = distance(pos, enemy['pos'])
        if dist < closest[1]:
            closest = enemy, dist
    return closest


# Get closest powerup to bomberman's position
def get_closest_powerup(state):
    length = len(state['powerups'])
    if length == 0:
        return None
    if length == 1:
        return state['powerups'][0]

    bomberman = state['bomberman']
    closest = None, float("inf")
    for powerup in state['powerups']:
        dist = distance(bomberman, powerup[0])
        if dist < closest[1]:
            closest = powerup, dist
    return closest[0]


# Get closest bomb to bomberman's position
def get_closest_bomb(state):
    length = len(state['bombs'])
    if length == 0:
        return None
    if length == 1:
        return state['bombs'][0]

    bomberman = state['bomberman']
    closest = None, float("inf")
    for bomb in state['bombs']:
        dist = distance(bomberman, bomb[0])
        if dist < closest[1]:
            closest = bomb, dist
    return closest[0]


# Determine if there are enemies in range of a given position
def enemy_in_range(map, state, pos, enemy_directions, range, in_evade=False, normal_range=2):
    for enemy in get_low_enemies(state):
        if in_range(map, state, pos, enemy, range, enemy_directions, False):
            return enemy
    if in_evade:
        for enemy in get_normal_enemies(state):
            if distance(pos, enemy['pos']) <= normal_range:
                # In range of normal or high enemy
                return enemy
    return False


# Check if a given position is free to move to
def check_if_can_move(map, state, p1, enemy_directions, range, use_in_range=False, ignore_destructible=False,
                      use_bomb_range=False, powerups=None, in_evade=False, normal_range=2, avoid_exit=False):
    enemies_exist = len(state['enemies']) != 0
    bombs_exist = len(state['bombs']) != 0
    use_bomb_range = use_bomb_range and not (powerups is not None and 'Detonator' in powerups and powerups['Detonator'])
    if bombs_exist:
        bomb = get_closest_bomb(state)
    return map[p1[0]][p1[1]] != 1 and \
           ((powerups is not None and 'Wallpass' in powerups and powerups['Wallpass']) or (
                   p1 not in state['walls'])) and \
           p1 not in [bomb[0] for bomb in state['bombs']] and \
           p1 not in [enemy['pos'] for enemy in state['enemies']] and \
           not (avoid_exit and p1 == state['exit']) and \
           not (use_in_range and enemies_exist and enemy_in_range(map, state, p1, enemy_directions, range,
                                                                  in_evade, normal_range) != False) and \
           not (use_bomb_range and bombs_exist and in_range(map, state, state['bomberman'], bomb[0],
                                                            bomb[2], None, True) and bomb[1] <= 2)


# Evade an enemy that is in close proximity to bomberman
def evade_enemy(map, state, start, enemy_directions, powerups=None, normal_range=2):
    enemy = get_closest_enemy(map, state, state['enemies'], powerups)
    return evade_bomb(map, state, start, enemy_directions, powerups, False, [enemy[0]['pos'], 3, 4], True, False,
                      normal_range)


# Evade a bomb on the map
def evade_bomb(map, state, start, enemy_directions, powerups=None, force_in_range=False, bomb=None,
               use_bomb_range=False, deciding_if_should_plant=False, normal_range=2, avoid_exit=False, prev_path=None,
               range_val=6):
    path = get_path_to_safety(map, state, start, enemy_directions, range_val, False, True, bomb, use_bomb_range,
                              powerups,
                              normal_range, avoid_exit, prev_path)
    if path is None:
        # No path to safety with cost < 3. Re-trying with cost <10. May Die
        path = get_path_to_safety(map, state, start, enemy_directions, range_val, True, True, bomb, use_bomb_range,
                                  powerups,
                                  normal_range, avoid_exit, prev_path)
        if path is None and not deciding_if_should_plant:
            for i in range(range_val - 1, 1, -1):
                # No path to safety with cost < 10. Re-trying using range i. May Die
                path = get_path_to_safety(map, state, start, enemy_directions, i, True, True, bomb, use_bomb_range,
                                          powerups, normal_range, avoid_exit, prev_path)
                if path is not None:
                    return path
            if path is None and not force_in_range:
                # No path to safety with cost < 10. Re-trying without using in_range. May Die
                path = get_path_to_safety(map, state, start, enemy_directions, None, True, False, bomb, False, powerups,
                                          normal_range, False, prev_path)
    return path


# Get path to a safe position from bombs and enemies
def get_path_to_safety(map, state, start, enemy_directions, range, detonator=False, use_in_range=True, bomb=None,
                       use_bomb_range=False, powerups=None, normal_range=2, avoid_exit=False, prev_path=None):
    candidates = []
    heuristic = {}

    if bomb is None:
        bomb = get_closest_bomb(state)

    bomb_radius = bomb[2]

    list = get_possible_next_nodes(map, state, start, enemy_directions, range, use_in_range, True, use_bomb_range,
                                   powerups, True, normal_range, avoid_exit)
    for direction in list:
        path = [direction[0]]
        cost = 1
        new_place = direction[1]
        heuristic[path[0]] = 0 if len(get_low_enemies(state)) == 0 else \
            get_closest_enemy_from_pos(state, get_next_pos(new_place, path[0]), get_low_enemies(state))[1]
        while cost < 3 or (detonator and cost < 10):

            if not in_range(map, state, new_place, bomb[0], bomb_radius, enemy_directions, True):
                candidates.append(path)
                break

            new_directions = get_possible_next_nodes(map, state, new_place, enemy_directions, range, use_in_range, True,
                                                     use_bomb_range, powerups, True, normal_range, avoid_exit)

            escape_routes = [dir[0] for dir in new_directions if
                             not in_range(map, state, get_next_pos(new_place, dir[0]), bomb[0], bomb_radius,
                                          enemy_directions, True)]

            for route in escape_routes:
                candidates.append(path + [route])

            if len(escape_routes) != 0:
                break

            new_places = [dir for dir in new_directions if dir[0] == direction[0]]
            if len(new_places) > 0:
                new_place = new_places[0][1]

            path.append(direction[0])
            cost += 1

    if len(candidates) == 0:
        return None

    candidates.sort(key=len)
    best_candidates = [candidate for candidate in candidates if
                       (len(candidate) - len(candidates[0])) <= 2]
    if prev_path in best_candidates:
        return prev_path
    else:
        min_heuristic = min(heuristic.values())
        same_heuristic = all([val == min_heuristic for val in [heuristic[c[0]] for c in best_candidates]])
        lst = [candidate for candidate in best_candidates if same_heuristic or heuristic[candidate[0]] != min_heuristic]
        return random.choice(lst)


# Inspired by in_range(self, character) by Professor Diogo Gomes
def in_range(map, state, friendly, enemy, radius, enemy_directions, ignore_destructible=False):
    if radius is None:
        return

    fx, fy = tuple(friendly)

    if 'id' in enemy:
        ex, ey = tuple(enemy['pos'])
        if enemy_directions is not None:
            try:
                dir = enemy_directions[enemy['id']]['direction']
                pass
            except KeyError:
                dir = None
        else:
            dir = None
    else:
        ex, ey = tuple(enemy)
        dir = None

    if fy == ey:
        for r in range(radius + 1):
            if map[fx + r][fy] == 1 or (not ignore_destructible and [fx + r, fy] in state['walls']):
                break  # protected by stone to the right
            if (ex, ey) == (fx + r, fy):
                return dir is None or (dir is Direction.LEFT or low_enemy_will_turn(map, state, enemy, dir))
        for r in range(radius + 1):
            if map[fx - r][fy] == 1 or (not ignore_destructible and [fx - r, fy] in state['walls']):
                break  # protected by stone to the left
            if (ex, ey) == (fx - r, fy):
                return dir is None or (dir is Direction.RIGHT or low_enemy_will_turn(map, state, enemy, dir))
    if fx == ex:
        for r in range(radius + 1):
            if map[fx][fy + r] == 1 or (not ignore_destructible and [fx, fy + r] in state['walls']):
                break  # protected by stone in the bottom
            if (ex, ey) == (fx, fy + r):
                return dir is None or (dir is Direction.UP or low_enemy_will_turn(map, state, enemy, dir))
        for r in range(radius + 1):
            if map[fx][fy - r] == 1 or (not ignore_destructible and [fx, fy - r] in state['walls']):
                break  # protected by stone in the top
            if (ex, ey) == (fx, fy - r):
                return dir is None or (dir is Direction.DOWN or low_enemy_will_turn(map, state, enemy, dir))

    return False


# Determine if a Smart.LOW enemy will turn switch direction shortly
def low_enemy_will_turn(map, state, enemy, dir, new_pos_list=None):
    walls_exist = len(state['walls']) != 0
    pos = enemy['pos']
    if new_pos_list is None:
        new_pos_list = get_next_pos_list(map, pos, dir, 2)
    return any([map[d[0]][d[1]] == 1 or (walls_exist and d in state['walls']) for d in new_pos_list])


# Get a list of next positions given the starting position and a direction
def get_next_pos_list(map, pos, dir, size):
    new_pos = get_next_pos(pos, dir)
    if size == 0 or is_out_of_bounds(map, new_pos):
        return []
    return [new_pos] + get_next_pos_list(map, new_pos, dir, size - 1)


# Check if a position is out of the bounds of the map
def is_out_of_bounds(map, pos):
    return pos[0] >= len(map) or pos[1] >= len(map[0])


# Get the next position given a starting position and a direction
def get_next_pos(pos, dir):
    position = [pos[0], pos[1]]
    if dir is Direction.LEFT:
        position[0] -= 1
    elif dir is Direction.RIGHT:
        position[0] += 1
    elif dir is Direction.UP:
        position[1] -= 1
    elif dir is Direction.DOWN:
        position[1] += 1

    return position


# Get a direction given a start and end positions
def get_direction(start, end):
    if start[1] == end[1]:
        if start[0] == end[0]:
            return None
        if start[0] > end[0]:
            return Direction.LEFT
        else:
            return Direction.RIGHT
    elif start[0] == end[0]:
        if start[1] > end[1]:
            return Direction.UP
        else:
            return Direction.DOWN
    else:
        return None


# Get ideal kill position for a given Smart.LOW enemy
def get_kill_position(map, state, enemy, enemy_directions):
    if enemy_directions is not None:
        try:
            dir = enemy_directions[enemy['id']]['direction']
            if dir is None:
                return None
            pass
        except KeyError:
            return None
    else:
        return None

    pos = [enemy['pos'][0], enemy['pos'][1]]
    for i in range(0, consts.KILL_POSITION_THRESHOLD):
        pos, dir = get_next_low_enemy_pos(pos, dir, map, state)

    return pos


# Get next position of a given Smart.LOW enemy accounting for possible changes of direction
def get_next_low_enemy_pos(pos, dir, map, state):
    walls_exist = len(state['walls']) != 0
    for i in range(0, 4):
        next_pos = get_next_pos(pos, dir)
        if map[next_pos[0]][next_pos[1]] == 1 or (walls_exist and next_pos in state['walls']):
            dir = consts.StringToDir["wasd"[("wasd".find(dir.value) + 1) % 4]]
        else:
            return (next_pos, dir)
    return None


# Pick a direction at random from the list of possible directions for bomberman's position
def random_move(map, game_state, enemy_directions):
    moves = get_possible_next_nodes(map, game_state, game_state['bomberman'],
                                    enemy_directions, 3, True, False)
    if len(moves) != 0:
        return [random.choice(moves)[0].value]
    else:
        return [""]


# Get list of all Smart.HIGH and Smart.NORMAL enemies currently on the map
def get_normal_enemies(game_state):
    return list(filter(lambda e: e['name'] in consts.normal_enemies, game_state['enemies']))


# Get list of all Smart.LOW enemies currently on the map
def get_low_enemies(game_state):
    return list(filter(lambda e: e['name'] in consts.low_enemies, game_state['enemies']))
