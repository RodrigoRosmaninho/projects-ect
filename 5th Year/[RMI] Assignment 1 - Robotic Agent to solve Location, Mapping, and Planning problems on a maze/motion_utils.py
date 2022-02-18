from enum import Enum

target_cell = None
motion_angle = None

move_queue = []
move_start = True

backtrack = None

dir_offset = {
    0: (1,0),
    90: (0,1),
    180: (-1,0),
    -180: (-1,0),
    -90: (0,-1),
}

class Move(Enum):
    TURN = 0
    MOVE = 1

def move_forward(rel_pos, pos, angle, keep_going=False):
    angle_lowlim = 2
    angle_midlim = angle_lowlim * 8

    position_lowlim = 0.05
    position_midlim = 0.1

    force_lowlim = 0.08
    force_midlim = 0.15

    delta = motion_angle - angle
    if delta > 180:
        delta -= 360
    elif delta < -180:
        delta += 360
    
    if abs(delta)>4:
        print("---Angle is too off to start moving")
        return rotate_towards(angle,motion_angle)

    print("---MOVING TO: "+str(target_cell)+(" (keep_going)" if keep_going else ""))

    lim = 0.15
    done = False

    # default: vertical movement
    print("---Motion Angle: "+str(motion_angle))
    og_main = rel_pos[1] # origin main coord -> y
    tg_main = target_cell[1] # target main coord -> y
    og_cross = rel_pos[0] # origin cross coord -> x
    tg_cross = target_cell[0] # target cross coord -> x
    if motion_angle % 180 == 0: # horizontal movement
        og_main = rel_pos[0]
        tg_main = target_cell[0]
        og_cross = rel_pos[1]
        tg_cross = target_cell[1]
    
    # if distance to target is very small, consider reached, if a bit small, progressively decrease velocity
    dist = tg_main - og_main
    # --- detect overshoot
    overshoot = False
    if motion_angle in [0,90]:
        overshoot = dist < 0
    elif motion_angle in [-180,180,-90]:
        overshoot = dist > 0
    if overshoot:
        print("--- overshot!")
    # ---
    # TODO: ignore slowing down when moving consecutively forward (receive argument, return tuple with (motor_l, motorr), finished to still differentiate reaching cell)

    if keep_going and overshoot:
        done = True
    else:
        if abs(dist) < position_midlim:
            if keep_going:
                done = True
            else:    
                if abs(dist) < position_lowlim:
                    if abs(delta)>4:
                        print("---Angle is too off to end movement")
                        return rotate_towards(angle,motion_angle)
                    return (0.0,0.0), True
                lim = abs(dist)*(force_lowlim-force_lowlim/2)/(position_midlim-position_lowlim)

    # adjust direction
    deviation = tg_cross - og_cross
    rot = 0

    # cross deviation is too high, turn harder
    if abs(deviation) >= position_lowlim:
        rot = 1*(deviation if motion_angle in [0,-90] else -deviation)
    # cross deviation is not high enough, adjust through angle
    else:
        rot = delta*(force_midlim-force_lowlim)/(angle_midlim-angle_lowlim)

    print("---Delta: "+str(delta))
    print("---Deviation: "+str(deviation))
    print("---Rot: "+str(rot))

    lwheel = max(min(lim,lim-rot),-lim)
    rwheel = max(min(lim,lim+rot),-lim)
    
    return (lwheel,rwheel), done

def rotate_towards(angle, target_angle):
    angle_lowlim = 2
    angle_midlim = angle_lowlim * 8

    force_lowlim = 0.02
    force_midlim = 0.15

    print("---ROTATING TOWARDS: "+str(target_angle))

    # calculate angle difference
    delta = target_angle-angle
    if delta > 180:
        delta -= 360
    elif delta < -180:
        delta += 360
    print("---Delta: "+str(delta))

    force = force_midlim

    # if angle delta is too low, progressively slow down
    if abs(delta) < angle_midlim:
        force = abs(delta)*(force_midlim-force_lowlim)/(angle_midlim-angle_lowlim)
        print("--- ...slowing down")
    
    # if delta < 0, turn left, else turn right
    if delta > angle_lowlim:
        return (-force,force), False
    elif delta < -angle_lowlim:
        return (force,-force), False

    # target angle was reached
    return (0.0,0.0), True

def enqueue_action(ac_id, arg):
    move_queue.append((ac_id,arg))

def get_move_queue_len():
    return len(move_queue)

def delete_move_queue():
    global move_queue
    
    move_queue = []

def move(rel_pos,pos,angle):
    global move_start, target_cell, motion_angle, backtrack

    res = None

    if len(move_queue) == 0:
        return (0.0,0.0)

    move_var = move_queue[0]
    # MOVE FORWARD
    if move_var[0] == Move.MOVE:
        keep_moving = len(move_queue)>1 and move_queue[1][0] == Move.MOVE

        if move_start:
            if backtrack is not None:
                rpos = backtrack
                backtrack = None
            else:
                rpos = (round(rel_pos[0]), round(rel_pos[1]))
            motion_angle = round(angle / 90) * 90
            offset = dir_offset[motion_angle]
            target_cell = (rpos[0]+offset[0],rpos[1]+offset[1])
        res = move_forward(rel_pos, pos, angle, keep_moving)
    # TURN TOWARDS ANGLE
    elif move_var[0] == Move.TURN:

        while len(move_queue) > 1 and move_queue[1][0] == Move.TURN:
            move_queue.pop(0)
            move_var = move_queue[0]
        target_angle = move_var[1]
        res = rotate_towards(angle, target_angle)
    move_start = False
    
    if res[1]: # move is done
        move_queue.pop(0)
        move_start = True
        return move(rel_pos, pos, angle)

    return res[0]