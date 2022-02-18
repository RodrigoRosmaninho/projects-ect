import numpy as np
import math
from enum import Enum

move_queue = []
class Move(Enum):
    TURN = 0
    MOVE = 1

class MovModel:
    def __init__(self, tx = 1, ty = 1, angle = 0):

        self.D = 1

        self._tx = tx # theoretical x position
        self._ty = ty # theoretical y position
        self._angle = angle # used to store last angle, should NOT be used by agent

        self._last_outl = 0
        self._last_outr = 0

        self._movedx = 0
        self._movedy = 0
        self._moveda = 0

        self.wall_thresh = 1 # max sensor distance considered for wall detection (further the distance from a wall, the larger the sensor error)
        self.CELLSIZ = 2

        self.errorAng = 2

        self.deltaAng = 0

        # For rotation action
        self.rotTarget = 0
        self.rotProgress = 0
        self.rotSign = 1 # {-1,1}
        self.rotMax = 0.15

        # For movement action
        self.movTarget = 2 # cell size
        self.movProgress = 0
        self.movMax = 0.15

        self.endAction = False
        self.first = True
        self.dumdum = False
        self.repeatRot = False
        
        self.distThresh = 1

        self.ref_angle = 0
        self.dev_angle = 0
        self.cur_angle = 0
    
    def _out(self,inl,inr):
        return ((inl + self._last_outl)/2,(inr + self._last_outr)/2)
    
    def _lin(self,outl,outr):
        lin = (outl + outr) / 2
        dx = lin * math.cos(math.radians(self._angle))
        dy = lin * math.sin(math.radians(self._angle))

        return (dx,dy)
    
    def _rot(self,outl,outr): # in degrees
        return math.degrees((outr-outl)/self.D)
    
    def _distcenter(self,sensor_dist): # converts sensor distance to distance to center
        return sensor_dist + self.D/2

    def angle_deviation(self,ang): # used in movement only
        # try to ignore angle error as much as possible
        delta = ang-self.cur_angle
        delta = (delta + 180) % 360 - 180
        if abs(delta) > self.errorAng:
            self.cur_angle = ang + (self.errorAng/2 if delta<0 else -self.errorAng/2)
            if self.cur_angle < -180:
                self.cur_angle = self.cur_angle + 360
            elif self.cur_angle > 180:
                self.cur_angle = self.cur_angle - 360

        # calculate current deviation
        print("---Estimated angle: "+str(self.cur_angle))
        self.dev_angle = self.cur_angle-self.ref_angle
        self.dev_angle = (self.dev_angle + 180) % 360 - 180

    
    def get_pos(self):
        return (self._tx, self._ty)
    
    def get_ang(self):
        return self._angle

    
    def simulDrive(self,lwheel,rwheel,newangle):

        outl,outr = self._out(lwheel,rwheel)

        self._last_outl = outl
        self._last_outr = outr

        self._moveda = self._rot(outl,outr)
        self._angle = newangle

        self.deltaAng = abs(self._angle-round(self._angle/90)*90)

        self._movedx,self._movedy = self._lin(outl,outr)
        self._tx = self._tx + self._movedx
        self._ty = self._ty + self._movedy
    
    # MOVEMENT

    def rotate(self, angle):
        print("---ROTATING (%s out of %s)" % (self.rotProgress,self.rotTarget))
        # Reached target (abs(remaining) should be 0) -> brake
        if abs(self.rotTarget)-abs(self.rotProgress) <= 0.5:
            if (angle % 90) <= self.errorAng or (angle % 90) >= 90-self.errorAng:
                self.endAction = True
            else:
                self.repeatRot = True
            self.rotProgress = 0
            return (-self._last_outl,-self._last_outr)
        
        outmax = (self.rotMax+abs(self._last_outl))/2 # assuming outl = -outr always
        rotmax = self._rot(-outmax,outmax)

        remaining = self.rotTarget-self.rotProgress

        lwheel = rwheel = 0
        
        if rotmax < abs(remaining):
            lwheel = (-self.rotMax) * self.rotSign
            rwheel = self.rotMax * self.rotSign
        else:
            rwheel = math.radians(remaining)-self._last_outr
            lwheel = -rwheel
        
        outl,outr = self._out(lwheel,rwheel)
        rot = self._rot(outl,outr)
        self.rotProgress += rot
        
        return lwheel,rwheel
    
    def forth(self, cdist, ldist, rdist, bdist):
        print("---MOVING FORWARD (%s out of %s)" % (self.movProgress,self.movTarget))
        # Reached target (abs(remaining) should be 0) -> brake
        if (cdist and cdist<=0.4) or abs(self.movTarget)-abs(self.movProgress) <= 0:
            self.endAction = True
            self.movProgress = 0
            return (-self._last_outl,-self._last_outr)

        outmax = (self.rotMax+abs(self._last_outl))/2 # assuming outl = outr always
        movmax = outmax

        print("---Ang: "+str(self.dev_angle))

        remaining = self.movTarget - self.movProgress

        lwheel = rwheel = 0

        if movmax < abs(remaining):
            
            closedist = 0.25
            rclose = rdist and rdist <= closedist
            lclose = ldist and ldist <= closedist
            if rclose or lclose:
                target_rot = math.radians(10 if rclose else -10)
            elif abs(self.dev_angle) > self.errorAng:
                target_rot = math.radians(-self.dev_angle/2)
            else:
                target_rot = 0
                
            if target_rot < 0: # turn right
                rwheel = (target_rot*self.D + self.movMax)*2 - self._last_outr
                lwheel = self.movMax
            elif target_rot > 0: # turn left
                rwheel = self.movMax
                lwheel = (self.movMax - target_rot*self.D)*2 - self._last_outl
            else:
                lwheel = rwheel = self.movMax

        else:
            rwheel = lwheel = remaining

        outl,outr = self._out(lwheel,rwheel)
        lim = outl
        self.movProgress += lim

        return lwheel,rwheel


    def move(self, cdist, ldist, rdist, bdist, angle):
        res = (0.0,0.0)
        if len(move_queue) == 0 or self.dumdum:
            return res

        if cdist >= self.distThresh:
            cdist = None
        if ldist >= self.distThresh:
            ldist = None
        if rdist >= self.distThresh:
            rdist = None
        if bdist >= self.distThresh:
            bdist = None

        next_move = move_queue[0]
        # MOVE FORWARD
        if next_move[0] == Move.MOVE:
            if self.first or self.endAction:
                self.cur_angle = angle
                self.endAction = False
                if cdist and cdist<1:
                    self.dumdum = True
                    return res
            self.angle_deviation(angle)
            res = self.forth(cdist,ldist,rdist,bdist)
        # TURN TOWARDS ANGLE
        elif next_move[0] == Move.TURN:
            if self.first or self.endAction or self.repeatRot:
                self.repeatRot = False
                print("---MOVE: "+str(next_move))
                approx_ang = round(angle/90)*90
                delta = abs(approx_ang - angle)
                if delta > self.errorAng or (delta < 360-self.errorAng and delta > 180):
                    approx_ang = angle
                if approx_ang < 0:
                    approx_ang += 360
                aux = next_move[1]
                self.ref_angle = aux
                if aux < 0:
                    aux += 360

                rotTarget1 = aux - approx_ang
                rotTarget2 = rotTarget1-360 if rotTarget1>=0 else 360+rotTarget1
                self.rotTarget = rotTarget1 if abs(rotTarget1)<abs(rotTarget2) else rotTarget2

                self.rotSign = self.rotTarget/abs(self.rotTarget) if self.rotTarget != 0 else 1

                self.endAction = False
            res = self.rotate(angle)
        
        self.first = False
        
        if self.endAction: # move is done
            move_queue.pop(0)

        return res
    
def enqueue_action(ac_id, arg):
    move_queue.append((ac_id,arg))

def get_move_queue_len():
    return len(move_queue)

def delete_move_queue():
    global move_queue
    
    move_queue = []

def get_move_queue_len():
    return len(move_queue)
