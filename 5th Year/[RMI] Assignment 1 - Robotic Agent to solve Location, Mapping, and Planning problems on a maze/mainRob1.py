
import sys
from croblink import *
from math import *
import xml.etree.ElementTree as ET
import math

CELLROWS=7
CELLCOLS=14

class MyRob(CRobLinkAngs):
    def __init__(self, rob_name, rob_id, angles, host):
        CRobLinkAngs.__init__(self, rob_name, rob_id, angles, host)
        
        self.on_start = True
        self.lap_count = 0
        self.lim = 0
        self.rot = 0
        self.rotr = 0
        self.rotl = 0

        self.speed_mx = 0.15
        self.csensor_mx = 7.0
        self.rlsensor_mx = 1.3
        self.rot_mx = 0.19

        self.lim_d = ((self.speed_mx)-self.speed_mx)/self.csensor_mx
        self.rot_d = self.rot_mx/self.rlsensor_mx

    # In this map the center of cell (i,j), (i in 0..6, j in 0..13) is mapped to labMap[i*2][j*2].
    # to know if there is a wall on top of cell(i,j) (i in 0..5), check if the value of labMap[i*2+1][j*2] is space or not
    def setMap(self, labMap):
        self.labMap = labMap

    def printMap(self):
        for l in reversed(self.labMap):
            print(''.join([str(l) for l in l]))

    def run(self):
        if self.status != 0:
            print("Connection refused or error")
            quit()

        state = 'stop'
        stopped_state = 'run'

        while True:
            self.readSensors()

            if self.measures.time > int(self.simTime):
                self.finish()
                quit()

            if self.measures.endLed:
                print(self.rob_name + " exiting")
                quit()

            if state == 'stop' and self.measures.start:
                state = stopped_state

            if state != 'stop' and self.measures.stop:
                stopped_state = state
                state = 'stop'

            if state == 'run':
                if self.measures.visitingLed==True:
                    state='wait'
                if self.measures.ground==0:
                    self.setVisitingLed(True);
                self.wander()
            elif state=='wait':
                self.setReturningLed(True)
                if self.measures.visitingLed==True:
                    self.setVisitingLed(False)
                if self.measures.returningLed==True:
                    state='return'
                self.driveMotors(0.0,0.0)
            elif state=='return':
                if self.measures.visitingLed==True:
                    self.setVisitingLed(False)
                if self.measures.returningLed==True:
                    self.setReturningLed(False)
                self.wander()
            

    def wander(self):

        if self.measures.ground == 0 and not self.on_start:
            self.lap_count+=1
            print("Lap "+str(self.lap_count))
        self.on_start = self.measures.ground == 0


        center_id = 0
        left_id = 1
        right_id = 2
        back_id = 3

        centre = self.measures.irSensor[center_id]
        right = self.measures.irSensor[right_id]
        lowlim = 0
        if right < lowlim:
            right = 0
        left = self.measures.irSensor[left_id]
        if left < lowlim:
            left = 0
        back = self.measures.irSensor[back_id]

        self.lim = centre * self.lim_d + self.speed_mx
        
        self.rot = ((right-left) * self.rot_d) * (1*centre if centre>=0.7 else 0.3*back)

        lwheel = max(min(0.15,self.lim-self.rot),-0.15)
        rwheel = max(min(0.15,self.lim+self.rot),-0.15)
        self.driveMotors(lwheel,rwheel)

        print("(Front, Back): "+str(centre)+", "+str(back)+")")
        print("(Left, Right): "+str(left)+", "+str(right)+")")
        print("(Rotr, Rotl): "+str(self.rotr)+", "+str(self.rotl)+")")
        print("(Lim, Rot): ("+str(self.lim)+", "+str(self.rot)+")")
        print("(left, right): ("+str(lwheel)+", "+str(rwheel)+")")
        print("-----")


rob_name = "pClient1"
host = "localhost"
pos = 1

for i in range(1, len(sys.argv),2):
    if (sys.argv[i] == "--host" or sys.argv[i] == "-h") and i != len(sys.argv) - 1:
        host = sys.argv[i + 1]
    elif (sys.argv[i] == "--pos" or sys.argv[i] == "-p") and i != len(sys.argv) - 1:
        pos = int(sys.argv[i + 1])
    elif (sys.argv[i] == "--robname" or sys.argv[i] == "-r") and i != len(sys.argv) - 1:
        rob_name = sys.argv[i + 1]
    else:
        print("Unkown argument", sys.argv[i])
        quit()

if __name__ == '__main__':
    rob=MyRob(rob_name,pos,[0.0,60.0,-60.0,180.0],host)
    rob.run()
