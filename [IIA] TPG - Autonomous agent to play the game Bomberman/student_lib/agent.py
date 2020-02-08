from student_lib.consts import Behaviour
from student_lib import pathfinding, consts, node
from student_lib.pathfinding import get_low_enemies, get_normal_enemies


class Agent:
    def __init__(self, map, powerups):
        self.state = Behaviour.WALL_HUNTING
        self.map = map
        self.powerups = powerups
        self.move_backlog = []
        self.target = None
        self.blocked_target = None
        self.caught_powerup = None
        self.low_enemy_directions = {}
        self.watchdog_timer_target = 0
        self.watchdog_counter_target = (None, 0)
        self.watchdog_counter_evade = (None, 0, 0)
        self.watchdog_timer_bomb = 0
        self.watchdog_counter_bomb = 0
        self.watchdog_timer_wall = 0
        self.blocked_walls = []
        self.enemy_is_blocked = False
        self.avoid_exit = False
        self.discovered_powerup = None
        self.path_to_safety = None

    # Call relevant methods to determine current state and execute respective method. Return next key on the backlog
    def get_next_key(self, game_state):
        self.compute_enemy_directions(game_state)
        last_state = self.state
        if self.caught_powerup is None:
            self.caught_powerup = not self.should_catch_powerup(game_state)

        self.avoid_exit = self.check_avoid_exit(game_state)
        self.check_self_state(game_state)

        if self.state is Behaviour.WALL_HUNTING:
            self.go_to_closest_wall(game_state)
            self.target = None
        elif self.state is Behaviour.WAIT:
            self.wait()
        elif self.state is Behaviour.BOMB_EVASION:
            self.evade_bomb(game_state)
        elif self.state is Behaviour.ENEMY_EVASION:
            self.evade_enemy(game_state)
        elif self.state is Behaviour.ITEM_HUNTING:
            self.go_to_closest_powerup(game_state)
        elif self.state is Behaviour.NORMAL_ENEMY_HUNTING:
            self.normal_enemy(game_state)
        elif self.state is Behaviour.LOW_ENEMY_HUNTING:
            self.low_enemy(game_state)
        elif self.state is Behaviour.EXIT:
            self.go_to_exit(game_state)
        else:
            self.wait()

        try:
            return self.move_backlog.pop(0), self.powerups
        except:
            return "", self.powerups

    # Determine current state
    def check_self_state(self, game_state):

        self.check_powerups(game_state)

        enemy_in_range = pathfinding.enemy_in_range(self.map, game_state, game_state['bomberman'],
                                                    self.low_enemy_directions,
                                                    4, True)

        if enemy_in_range and self.target_is_low_enemy() and self.target['id'] == enemy_in_range['id']:
            in_danger = pathfinding.distance(game_state['bomberman'], self.target['pos']) <= 2
        else:
            in_danger = enemy_in_range

        if in_danger and enemy_in_range is not None:
            if self.check_evasions(game_state, enemy_in_range) == 1:
                return

        if len(game_state['enemies']) == 0 and len(game_state['exit']) != 0 and (
                game_state['timeout'] - game_state['step']) <= 250:
            # Timeout near, going to exit without picking up powerup
            self.state = Behaviour.EXIT
            return

        if len(game_state['bombs']) == 0 and in_danger:
            # ENEMY IN RANGE!
            self.target = None
            bomb = self.plant_bomb(game_state)
            if not bomb:
                # No bomb, evading
                self.state = Behaviour.ENEMY_EVASION
                return
            # else: Bomb planted

        if len(game_state['bombs']) != 0 and self.state in [Behaviour.WAIT, Behaviour.ENEMY_EVASION] and in_danger:
            # waiting but enemy is in range, confirming threat
            if self.state is Behaviour.WAIT and pathfinding.get_closest_bomb(game_state)[1] <= 1:
                # No threat
                pass
            else:
                # ENEMY IN RANGE WHILE WAITING
                self.target = None
                self.state = Behaviour.ENEMY_EVASION
                return

        if len(self.move_backlog) != 0:
            return

        if len(game_state['bombs']) != 0:
            if self.state != Behaviour.WAIT and self.state != Behaviour.BOMB_EVASION:
                self.state = Behaviour.BOMB_EVASION

        elif len(game_state['powerups']) != 0:
            self.caught_powerup = False
            self.check_powerups(game_state)
            self.state = Behaviour.ITEM_HUNTING

        elif len(get_normal_enemies(game_state)) != 0:
            self.state = Behaviour.NORMAL_ENEMY_HUNTING

        elif len(get_low_enemies(game_state)) != 0:
            self.state = Behaviour.LOW_ENEMY_HUNTING

        elif (len(game_state['walls']) != 0) and (
                (len(game_state['exit']) == 0) or (not self.caught_powerup)):
            self.state = Behaviour.WALL_HUNTING

        else:
            self.state = Behaviour.EXIT
            if game_state['bomberman'] == game_state['exit']:
                self.target = None
                self.state = Behaviour.WAIT

    # Send empty key (WAIT state)
    def wait(self):
        self.move_backlog.append("")

    # Verify if there are escape routes and place bomb on bomberman's current position
    def plant_bomb(self, game_state):
        if game_state['bomberman'] in game_state['walls']:
            return False

        path = pathfinding.evade_bomb(self.map, game_state, game_state['bomberman'], self.low_enemy_directions,
                                      self.powerups, True, [game_state['bomberman'], 1, 4], False, True, 2,
                                      self.avoid_exit)

        if path is None and self.watchdog_counter_bomb <= 50:
            if self.avoid_exit:
                self.blocked_walls.append(self.target)
                self.watchdog_timer_bomb -= 5
            self.watchdog_counter_bomb += 1
            # No path found, not planting bomb
            return False
        self.blocked_walls = []
        self.path_to_safety = None
        self.move_backlog.insert(0, "B")
        self.watchdog_counter_bomb = 0
        self.watchdog_timer_bomb = 0
        return True

    # Seek and destroy closest wall to bomberman's position (WALL_HUNTING state)
    def go_to_closest_wall(self, game_state):
        if len(game_state['walls']) == len(self.blocked_walls):
            self.blocked_walls = []
        if len(game_state['walls']) == 0:
            self.enemy_is_blocked = False
            self.watchdog_counter_target = (None, 0)
            self.target = None
            return

        if len(self.move_backlog) == 0:
            use_in_range = True

            if self.target is None or self.target == "BOMB":
                if self.enemy_is_blocked and self.watchdog_counter_target[1] > 4 and self.watchdog_counter_target[0][
                    'name'] in consts.normal_enemies:
                    # getting far wall
                    self.target = pathfinding.get_far_wall(self.map, game_state, self.watchdog_counter_target[0]['pos'],
                                                           self.blocked_walls)
                else:
                    self.target = pathfinding.get_closest_wall(self.map, game_state, self.blocked_walls,
                                                               self.blocked_target)
                self.watchdog_timer_wall = game_state['step']

            if self.target is None:
                self.target = pathfinding.get_closest_wall(self.map, game_state)
                if self.target is None:
                    return
                if self.target in self.blocked_walls:
                    use_in_range = False

            if (game_state['step'] - self.watchdog_timer_wall) >= 70:
                # Stuck with same wall for >= 70 steps, going for next closest wall
                self.blocked_walls.append(self.target)
                self.target = None
                return

            if pathfinding.distance(self.target, game_state['bomberman']) <= 1 and game_state['bomberman'] not in \
                    game_state['walls']:
                self.target = None
                bomb = self.plant_bomb(game_state)
                if bomb:
                    self.enemy_is_blocked = False
                    self.watchdog_counter_target = (None, 0)
                    self.blocked_target = None
                    self.blocked_walls = []
                return

            force_all_nodes = False
            if len(game_state['walls']) == len(self.blocked_walls):
                force_all_nodes = True

            path = pathfinding.get_path(self.map, game_state, game_state['bomberman'], self.target,
                                        self.low_enemy_directions, self.powerups, False, use_in_range, self.avoid_exit,
                                        force_all_nodes)

            if isinstance(path, node.Node):
                self.move_backlog = pathfinding.random_move(self.map, game_state, self.low_enemy_directions)
                self.blocked_walls.append(self.target)
                self.target = None
                return

            try:
                self.move_backlog = [i[0].value for i in path][:consts.SAVE_WALL_PATH]
            except:
                return

    # Seek and destroy closest Smart.HIGH or Smart.NORMAL enemy to bomberman's position (NORMAL_ENEMY_HUNTING state)
    def normal_enemy(self, game_state):
        if self.enemy_is_blocked:
            self.go_to_closest_wall(game_state)
            return

        if len(self.move_backlog) == 0:
            if self.target is None or self.target == 'BOMB':
                self.target, dist = pathfinding.get_closest_enemy(self.map, game_state, get_normal_enemies(game_state),
                                                                  self.powerups)
                self.watchdog_timer_target = game_state['step']
                if self.watchdog_counter_target[0] is None or self.watchdog_counter_target[0]['id'] != self.target[
                    'id']:
                    self.watchdog_counter_target = (self.target, 1)
                else:
                    self.watchdog_counter_target = (self.target, self.watchdog_counter_target[1] + 1)
            else:
                self.target = [enemy for enemy in get_normal_enemies(game_state) if enemy['id'] == self.target['id']][0]
                if self.target is None:
                    return

            if ((game_state['step'] - self.watchdog_timer_target) >= consts.WATCHDOG_TIME) or (
                    self.watchdog_counter_target[1] > 10):
                # Stuck with same target for >= consts.WATCHDOG_TIME steps, going for closest wall
                self.target = None
                self.enemy_is_blocked = True
                return

            if pathfinding.in_range(self.map, game_state, self.target['pos'], game_state['bomberman'], 2, None, True):
                self.target = None
                self.plant_bomb(game_state)
                return

            path = pathfinding.get_path(self.map, game_state, game_state['bomberman'], self.target['pos'],
                                        self.low_enemy_directions, self.powerups, False, True)

            if isinstance(path, node.Node):
                self.blocked_target = {'pos': path.pos}
                self.target = None
                # Enemy is Blocked
                self.enemy_is_blocked = True
                return

            self.move_backlog = [i[0].value for i in path][:consts.SAVE_ENEMY_PATH]
        else:
            pass

    # Seek and destroy closest Smart.LOW enemy to bomberman's position (LOW_ENEMY_HUNTING state)
    def low_enemy(self, game_state):
        if self.enemy_is_blocked:
            self.go_to_closest_wall(game_state)
            return

        if len(self.move_backlog) == 0:
            kill_pos = None
            if self.target is None or self.target == 'BOMB':

                self.target, dist = pathfinding.get_closest_enemy(self.map, game_state, get_low_enemies(game_state),
                                                                  self.powerups)
                kill_pos = pathfinding.get_kill_position(self.map, game_state, self.target, self.low_enemy_directions)

                if kill_pos is None:
                    self.blocked_target = self.target
                    self.target = None
                    self.enemy_is_blocked = True
                    return

                self.watchdog_timer_target = game_state['step']

                if self.watchdog_counter_target[0] is None or self.watchdog_counter_target[0]['id'] != self.target[
                    'id']:
                    self.watchdog_counter_target = (self.target, 1)
                else:
                    self.watchdog_counter_target = (self.target, self.watchdog_counter_target[1] + 1)
            else:
                self.target = [enemy for enemy in get_low_enemies(game_state) if enemy['id'] == self.target['id']][0]
                if self.target is None:
                    return
                kill_pos = pathfinding.get_kill_position(self.map, game_state, self.target, self.low_enemy_directions)
                if kill_pos is None:
                    self.target = None
                    return

            if ((game_state['step'] - self.watchdog_timer_target) >= consts.WATCHDOG_TIME_LOW) or (
                    self.watchdog_counter_target[1] > 10):
                # Stuck with same target for >= consts.WATCHDOG_TIME steps, going for closest wall
                self.target = None
                self.watchdog_counter_target = (None, 0)
                self.enemy_is_blocked = True
                return

            if pathfinding.distance(game_state['bomberman'], kill_pos) < 1:
                self.target = None
                self.plant_bomb(game_state)
                return

            path = pathfinding.get_path(self.map, game_state, game_state['bomberman'], kill_pos,
                                        self.low_enemy_directions, self.powerups, True, True)

            if isinstance(path, node.Node):
                self.blocked_target = {'pos': path.pos}
                self.target = None
                # Enemy is Blocked
                self.enemy_is_blocked = True
                return

            if True or False and len(path) <= consts.KILL_POSITION_THRESHOLD:
                if pathfinding.evade_bomb(self.map, game_state, kill_pos, self.low_enemy_directions, None, True,
                                          [kill_pos, 4, 4],
                                          False, True, 2, True, None, 5) is None:
                    # kill position unsuitable
                    self.target = None
                    return

            self.move_backlog = [i[0].value for i in path][:consts.SAVE_ENEMY_PATH]
        else:
            pass

    # Seek and acquire closest powerup to bomberman's position (ITEM_HUNTING state)
    def go_to_closest_powerup(self, game_state):
        if self.enemy_is_blocked:
            self.go_to_closest_wall(game_state)
            self.target = None
            return

        if self.target is None or len(self.move_backlog) == 0:
            self.target = pathfinding.get_closest_powerup(game_state)

            if self.target is None:
                return

            if self.target[1] not in self.powerups:
                self.powerups[self.target[1]] = False

            path = pathfinding.get_path(self.map, game_state, game_state['bomberman'], self.target[0],
                                        self.low_enemy_directions, self.powerups, True, True, self.avoid_exit)

            if isinstance(path, node.Node):
                self.target = None
                # Enemy is Blocked
                self.enemy_is_blocked = True
                return

            self.move_backlog = [i[0].value for i in path][:consts.SAVE_WALL_PATH]

    # Navigate to exit (EXIT state)
    def go_to_exit(self, game_state):
        if len(self.move_backlog) == 0:
            self.target = game_state['exit']

            path = pathfinding.get_path(self.map, game_state, game_state['bomberman'], self.target, None, self.powerups,
                                        True, False, False, True)

            try:
                self.move_backlog = [i[0].value for i in path][:consts.SAVE_EXIT_PATH]
            except:
                return

    # Evade enemy in close proximity to bomberman (ENEMY_EVASION state)
    def evade_enemy(self, game_state):
        path = pathfinding.evade_enemy(self.map, game_state, game_state['bomberman'], self.low_enemy_directions,
                                       self.powerups)
        if path is not None:
            self.move_backlog = [i.value for i in path][:consts.SAVE_BOMB_EVASION_PATH]

    # Evade bomb in close proximity to bomberman (BOMB_EVASION state)
    def evade_bomb(self, game_state):

        if len(game_state['bombs']) != 0 and (self.target is None or len(self.move_backlog) == 0):

            bomb = pathfinding.get_closest_bomb(game_state)
            normal_range = 2
            in_danger = pathfinding.in_range(self.map, game_state, game_state['bomberman'], bomb[0], bomb[2],
                                             self.low_enemy_directions, True)

            if in_danger:
                if self.watchdog_timer_bomb >= 100:
                    # No way out, reducing normal_range to 1
                    normal_range = 1
                path = pathfinding.evade_bomb(self.map, game_state, game_state['bomberman'], self.low_enemy_directions,
                                              self.powerups, self.has_powerup('Detonator'), None, False, False,
                                              normal_range, self.avoid_exit, self.path_to_safety)

                self.watchdog_timer_bomb += 1
                if self.has_powerup("Detonator") and self.watchdog_timer_bomb >= 120:
                    # No way out, blowing up to avoid timeout! :-(
                    self.move_backlog = ["A"]
                    self.watchdog_timer_bomb = 0

                if path is not None:
                    self.path_to_safety = path[1:]
                    self.move_backlog = [i.value for i in path][:consts.SAVE_BOMB_EVASION_PATH]
                    self.target = "BOMB"

            else:
                self.watchdog_timer_bomb = 0
                self.target = None
                self.path_to_safety = None
                if self.has_powerup("Detonator"):
                    if "A" not in self.move_backlog:
                        self.move_backlog = ["A"]
                else:
                    self.state = Behaviour.WAIT

    # Check if given powerup has been caught before
    def has_powerup(self, query):
        return query in self.powerups and self.powerups[query]

    # Compute Smart.LOW enemies' current directions and save them in a dictionary
    def compute_enemy_directions(self, game_state):
        if len(self.low_enemy_directions) == 0:
            for enemy in get_low_enemies(game_state):
                self.low_enemy_directions[enemy['id']] = {'last_pos': enemy['pos'], 'direction': None}
        else:
            for enemy in get_low_enemies(game_state):
                last_pos = self.low_enemy_directions[enemy['id']]['last_pos']
                direction = pathfinding.get_direction(last_pos, enemy['pos'])
                if direction is None:
                    direction = self.low_enemy_directions[enemy['id']]['direction']
                self.low_enemy_directions[enemy['id']] = {'last_pos': enemy['pos'], 'direction': direction}

    # Check if the exit should be avoided (Powerup still not caught)
    def check_avoid_exit(self, game_state):
        return len(game_state['enemies']) == 0 and len(game_state['exit']) != 0 and not self.caught_powerup and (
                game_state['timeout'] - game_state['step']) > 250

    # Check that the current target is a Smart.LOW enemy
    def target_is_low_enemy(self):
        return self.target is not None and 'pos' in self.target and self.target['name'] in consts.low_enemies

    # Determine if the current level's powerup should be actively sought out.
    # Information on levels and respective poweups is sourced from game.py
    # Should that prove to be impossible, method always returns True
    def should_catch_powerup(self, game_state):
        try:
            from game import LEVEL_POWERUPS
            powerup_name = LEVEL_POWERUPS[game_state['level']].name
            if powerup_name not in consts.desired_powerups:
                return False
            need = consts.desired_powerups[powerup_name]
            if need is consts.Need.ONE and powerup_name in self.powerups and self.powerups[powerup_name]:
                return False
            return True
        except:
            return True

    # Check if the current level's powerup has been caught. Deal with control variables for that purpose
    def check_powerups(self, game_state):
        if not self.caught_powerup and self.discovered_powerup is None and len(game_state['powerups']) != 0:
            powerup = game_state['powerups'][0][1]
            self.discovered_powerup = powerup
            if powerup not in self.powerups:
                self.powerups[powerup] = False

        # Check if item was caught
        if not self.caught_powerup and self.discovered_powerup is not None:
            if len(game_state['powerups']) == 0:
                self.powerups[self.discovered_powerup] = True
                self.caught_powerup = True
                self.target = None

    # Perform checks to avoid an infinite loop while evading an enemy which is also the current target
    def check_evasions(self, game_state, enemy_in_range):
        if self.watchdog_counter_evade[0] is not None and self.watchdog_counter_evade[0]['id'] == enemy_in_range['id']:
            if self.watchdog_counter_evade[1] > 50 and (game_state['step'] - self.watchdog_counter_evade[2]) < 100:
                self.watchdog_counter_evade = (None, 0, 0)
                self.watchdog_counter_target = (None, 0)
                self.blocked_walls = []
                self.path_to_safety = None
                self.watchdog_counter_bomb = 0
                self.watchdog_timer_bomb = 0
                self.enemy_is_blocked = False
                self.move_backlog = ["B", "A"]
                # blowing up
                return 1
            self.watchdog_counter_evade = (enemy_in_range, self.watchdog_counter_evade[1] + 1, game_state['step'])
        else:
            self.watchdog_counter_evade = (enemy_in_range, 1, game_state['step'])
        return 0
