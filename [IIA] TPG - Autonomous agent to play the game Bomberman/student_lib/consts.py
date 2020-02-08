from enum import IntEnum, Enum

BOMB_SAFETY_RADIUS = 5
ENEMY_IN_RANGE = 3
SAVE_ENEMY_PATH = 1
SAVE_WALL_PATH = 1
SAVE_EXIT_PATH = 1
SAVE_BOMB_EVASION_PATH = 1
RESEND_ATTEMPTS = 1
KILL_POSITION_THRESHOLD = 5
MAX_SEARCH_NODES = 400
WATCHDOG_TIME = 100
WATCHDOG_TIME_LOW = 150

normal_enemies = [
    "Oneal",
    "Minvo",
    "Ovapi",
    "Pass",
    "Kondoria"
]

low_enemies = [
    "Balloom",
    "Doll"
]


class Behaviour(IntEnum):
    NORMAL_ENEMY_HUNTING = 0
    ENEMY_EVASION = 1
    LOW_ENEMY_HUNTING = 2
    WALL_HUNTING = 3
    ITEM_HUNTING = 4
    BOMB_EVASION = 5
    EXIT = 6
    WAIT = 7


class Direction(Enum):
    UP = "w"
    DOWN = "s"
    LEFT = "a"
    RIGHT = "d"


StringToDir = {
    "w": Direction.UP,
    "s": Direction.DOWN,
    "a": Direction.LEFT,
    "d": Direction.RIGHT
}


class Need(IntEnum):
    MANY = 0,
    ONE = 1


desired_powerups = {
    "Flames": Need.MANY,
    "Detonator": Need.ONE,
    "Wallpass": Need.ONE,
    "Speed": Need.MANY,
    "Mystery": Need.MANY
}
