import sys
from croblink import *
from math import *
import xml.etree.ElementTree as ET
import motion_utils
from motion_utils import *
import utils
from utils import *

CELLROWS=7
CELLCOLS=14

class MyRob(CRobLinkAngs):
    def __init__(self, rob_name, rob_id, angles, host):
        CRobLinkAngs.__init__(self, rob_name, rob_id, angles, host)
        
        self.rob_name = rob_name
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

        #self.lim_d = -self.speed_mx/self.csensor_mx
        self.lim_d = ((self.speed_mx)-self.speed_mx)/self.csensor_mx
        self.rot_d = self.rot_mx/self.rlsensor_mx

        self.map = [[None for col in range(CELLCOLS*2-1)] for row in range(CELLROWS*2-1)]
        self.map[CELLROWS-1][CELLCOLS-1] = Cell((0,0), None, None, None, None, False)
        self.stack = [self.map[CELLROWS-1][CELLCOLS-1]]
        self.beacons = {}


    def run(self):
        if self.status != 0:
            print("Connection refused or error")
            quit()

        state = 'stop'
        stopped_state = 'run'

        while True:
            print("\n----------")

            self.readSensors()

            if utils.initial_pos is None and self.measures.gpsReady:
                utils.initial_pos = (self.measures.x, self.measures.y)

            relative_pos = gps_to_relative(self.measures.x, self.measures.y)
            adjusted_ir_measurements = get_compass_adjusted_measurements(self.measures.irSensor, self.measures.compass)
            
            print(relative_pos)
            print(self.measures.compass)

            rpos = (round(relative_pos[0]), round(relative_pos[1]))

            if get_move_queue_len() != 0 and motion_utils.move_queue[0][0] == Move.MOVE:
                if self.measures.irSensor[0] >= 3:
                    print("WHOOPS")
                    print(str(cell))
                    d = Direction(motion_utils.move_queue[0][1])
                    setattr(cell, d.name.lower(), True)
                    target = rev_dict[d]
                    tcell = cell_at_pos(self.map, (rpos[0] + target[0], rpos[1] + target[1]))
                    try:
                        setattr(tcell, target[2].name.lower(), True)
                    except:
                        print("\nEXCEPTION\n")
                        #print(build_map(self.map))
                        #sys.exit(0)
                    delete_move_queue()
                    enqueue_action(Move.TURN, target[2].value)
                    enqueue_action(Move.MOVE, target[2].value)
                    motion_utils.backtrack = (rpos[0] + target[0], rpos[1] + target[1])
                    print(str(tcell))
                    print("END WHOOPS")

            if ((relative_pos[0] % 1) < 0.1 or (relative_pos[0] % 1 > 0.9)) and ((relative_pos[1] % 1) < 0.1 or (relative_pos[1] % 1 > 0.9)) and ((self.measures.compass % 90) < 2 or (self.measures.compass % 90) > 88):
                if cell_at_pos(self.map, rpos) is None:
                    gpos = relative_to_grid(rpos)
                    self.map[gpos[1]][gpos[0]] = Cell(rpos, None, None, None, None, False)
                
                cell = cell_at_pos(self.map, rpos)
                cell.measurements[0].append(adjusted_ir_measurements[0] + ((relative_pos[1] % 1) if relative_pos[1] < rpos[1] else 0))
                cell.measurements[1].append(adjusted_ir_measurements[1] + ((relative_pos[0] % 1) if relative_pos[0] < rpos[0] else 0))
                cell.measurements[2].append(adjusted_ir_measurements[2] + ((relative_pos[1] % 1) if relative_pos[1] > rpos[1] else 0))
                cell.measurements[3].append(adjusted_ir_measurements[3] + ((relative_pos[0] % 1) if relative_pos[0] > rpos[0] else 0))

                print(str(adjusted_ir_measurements))

            if get_move_queue_len() == 0 or (target_cell is not None and move_forward(rpos, rpos, self.measures.compass) == (0,0)):
                backtrack = None
                
                cell = cell_at_pos(self.map, rpos)

                while cell in self.stack: self.stack.remove(cell)

                for m in cell.measurements:
                    if len(m) > 0:
                        print(sum(m)/len(m))

                cell.up = adjusted_ir_measurements[0] >= 1.7 #(sum(cell.measurements[0]) / len(cell.measurements[0])) > 1.7
                cell.right = adjusted_ir_measurements[1] >= 1.7#(sum(cell.measurements[1]) / len(cell.measurements[1])) > 1.7
                cell.down = adjusted_ir_measurements[2] >= 1.7 #(sum(cell.measurements[2]) / len(cell.measurements[2])) > 1.7
                cell.left = adjusted_ir_measurements[3] >= 1.7#(sum(cell.measurements[3]) / len(cell.measurements[3])) > 1.7

                print(str(cell))

                for wall, pos, rev in [(cell.up, (0, 1), "down"), (cell.right, (1, 0), "left"), (cell.down, (0, -1), "up"), (cell.left, (-1, 0), "right")]:
                #for wall, pos, rev in get_adjacent_cells(cell,self.measures.compass):
                    pos = (cell.pos[0] + pos[0], cell.pos[1] + pos[1])
                    
                    if cell_at_pos(self.map, pos) is None: #and not wal:
                        gpos = relative_to_grid(pos)
                        self.map[gpos[1]][gpos[0]] = Cell(pos, None, None, None, None, False)
                        #self.stack.append(cell_at_pos(self.map, pos))

                    c = cell_at_pos(self.map, pos)
                    if c is not None:
                        setattr(c, rev, wall)
                        if not wall and not c.visited and not cell.visited and any([f is None for f in [c.up, c.right, c.down, c.left]]):
                            print(str(c) + "-" + str([c.up, c.right, c.down, c.left]))
                            self.stack.append(c)

                cell.visited = True
                cell.beacon = self.measures.ground

                if cell.beacon != -1:
                    self.beacons[cell.beacon] = cell

            eval, path = eval_beacon_path(self.map, self.beacons, int(self.nBeacons))
            if eval or len(self.stack) == 0 or int(self.simTime) - self.measures.time < 15:
                print("\nDONE\n")
                fmap = build_map(self.map)
                print(fmap)
                print("\n" + str(path[:-1]) + "\n" + path[2] + "\n")
                with open(filename, 'w') as f:
                    print(path[2], file=f, end="")
                self.finish()
            elif get_move_queue_len() == 0 or (target_cell is not None and move_forward(rpos, rpos, self.measures.compass) == (0,0)):
                print(str(self.stack))
                print(str(get_path(self.map, cell, self.stack[-1].pos)))
                prev_direction = self.measures.compass

                tcell = self.stack[-1]
                while is_improper(tcell) or not any([f is None for f in [tcell.up, tcell.right, tcell.down, tcell.left]]):
                    if len(self.stack) > 0:
                        self.stack.pop()
                    if len(self.stack) > 0:
                        tcell = self.stack[-1]
                    else:
                        tcell = None
                        break

                if tcell is not None:
                    path = get_path(self.map, cell, tcell.pos)
                    if path is None:
                        self.stack.pop()
                        path = []

                    for step in path:
                        if abs(prev_direction - step[0].value) > 5:
                            enqueue_action(Move.TURN, step[0].value)
                            enqueue_action(Move.MOVE, step[0].value)
                            #enqueue_action(Move.TURN, step[0].value)
                            prev_direction = step[0].value
                        else:
                            pass
                            enqueue_action(Move.MOVE, step[0].value)
                            #enqueue_action(Move.TURN, step[0].value)
                        
                    print(str(move_queue))

            if self.measures.endLed:
                print(self.rob_name + " exiting")
                quit()

            if state == 'stop' and self.measures.start:
                state = stopped_state

            if state != 'stop' and self.measures.stop:
                stopped_state = state
                state = 'stop'

            if state == 'run':
                print("relative_pos: " + str(relative_pos))
                if self.measures.visitingLed==True:
                    state='wait'
                if self.measures.ground==0:
                    self.setVisitingLed(True);
                self.wander(cell)
            elif state=='wait':
                self.setReturningLed(True)
                if self.measures.visitingLed==True:
                    self.setVisitingLed(False)
                if self.measures.returningLed==True:
                    state='return'
                self.driveMotors(0.0,0.0)
            elif state=='return':
                print("relative_pos: " + str(relative_pos))
                if self.measures.visitingLed==True:
                    self.setVisitingLed(False)
                if self.measures.returningLed==True:
                    self.setReturningLed(False)
                self.wander(cell)
            

    def wander(self, cell):

        center_id = 0
        left_id = 1
        right_id = 2
        back_id = 3
        center = self.measures.irSensor[center_id]
        left = self.measures.irSensor[left_id]
        right = self.measures.irSensor[right_id]
        back = self.measures.irSensor[back_id]

        pos = (self.measures.x,self.measures.y)
        compass = self.measures.compass

        #print("\n----------")
        lwheel,rwheel = move(gps_to_relative(pos[0],pos[1]),pos,compass)
        #print("initial_pos: " + str(utils.initial_pos))
        #print("stack: " + str(self.stack))
        #print("move_queue: " + str(move_queue))
        #print("path to first stack element: " + str(get_path(self.map, cell, self.stack[-1].pos)))
        #print("(gpsReady, x, y): (" + str(self.measures.gpsReady) + ", " + str(self.measures.x) + ", " + str(self.measures.y) + ")")
        #print("Rel_Pos: " + str(gps_to_relative(pos[0],pos[1])))
        #print("(gpsDirReady, dir): (" + str(self.measures.gpsDirReady) + ", " + str(self.measures.dir) + ")")
        #print("(compassReady, compass): (" + str(self.measures.compassReady) + ", " + str(self.measures.compass) + ")")
        print("Motors: "+str((lwheel,rwheel)))
        print("ground: " + str(self.measures.ground))
        self.driveMotors(lwheel,rwheel)

rob_name = "pClient1"
host = "localhost"
pos = 1
filename = "planning.out"

for i in range(1, len(sys.argv),2):
    if (sys.argv[i] == "--host" or sys.argv[i] == "-h") and i != len(sys.argv) - 1:
        host = sys.argv[i + 1]
    elif (sys.argv[i] == "--pos" or sys.argv[i] == "-p") and i != len(sys.argv) - 1:
        pos = int(sys.argv[i + 1])
    elif (sys.argv[i] == "--robname" or sys.argv[i] == "-r") and i != len(sys.argv) - 1:
        rob_name = sys.argv[i + 1]
    elif (sys.argv[i] == "--file" or sys.argv[i] == "-f") and i != len(sys.argv) - 1:
        filename = sys.argv[i + 1]
    else:
        print("Unkown argument", sys.argv[i])
        quit()

if __name__ == '__main__':
    rob=MyRob(rob_name,pos,[0.0,90.0,-90.0,180.0],host)
    rob.run()
