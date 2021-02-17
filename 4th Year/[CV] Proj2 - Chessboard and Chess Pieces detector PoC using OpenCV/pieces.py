import cv2
import numpy as np
from geometry import *

piece_list = ['p','r','n','b','q','k']

class Grid:
    def __init__(self,white=True):
        self.col = 'l' if white else 'd'
        self.pieces = {p: [] for p in piece_list}
        self.contours = {}

tile_size = 60

blacks = {}

piece_contours = {}
piece_num = {
    'p': 8,
    'r': 2,
    'n': 2,
    'b': 2,
    'q': 1,
    'k': 1
}
piece_img = {}

contour_candidates = {}

board = []
lastboard = []
same_board_cnt = 0
switch = 10 # frames to update board

for piece in piece_num:
    im = cv2.imread('gfx/template{}W.png'.format(piece.upper()),cv2.IMREAD_GRAYSCALE)
    cont,_ = cv2.findContours(im, cv2.RETR_LIST, cv2.CHAIN_APPROX_NONE)
    piece_contours[piece]=cont[0]

    piece_img[piece] = cv2.imread("gfx/Chess_" + piece.lower() + "lt60.png", cv2.IMREAD_UNCHANGED)

def find_contour_for_piece(contours,key,piece):
    sim_threshold = 1.5
    result=[]
    #print("-----\nKey {}".format(key))
    for i,c in contours.items():
        ret = cv2.matchShapes(c,piece,1,0.0)
        #print("{}: {}".format(i,ret))
        if ret<sim_threshold:
            if i in contour_candidates:
                if contour_candidates[i][1]>ret:
                    contour_candidates[i]=(key,ret,c,i)
                    #print(i)
            else:
                contour_candidates[i]=(key,ret,c,i)
                #print(i)

def find_all_pieces(grid,contours):
    contour_candidates.clear()
    for k,c in piece_contours.items():
        find_contour_for_piece(contours,k,c)

    for p in piece_num:
        tmp=list(contour_candidates.values())
        tmp.sort(key=lambda m:m[1])
        grid.contours[p]=[(v[2],v[3]) for v in tmp if v[0]==p]#[:(piece_num[p])]

    ret = []
    for piece in grid.contours.values():
        for p in piece:
            ret.append(p[0])
    return ret

def get_piece_in_board(piece_cont,grid1,grid2):
    m = cv2.moments(piece_cont)
    contx, conty = m['m10'] / m['m00'], m['m01'] / m['m00']

    gx,gy=get_pos_in_grid(grid1,grid2,contx,conty)

    return gx,gy

def fill_board(grid,g1,g2):
    global lastboard,board,same_board_cnt

    for k in grid.contours:
        #print(k)
        positions = []
        for cont in grid.contours[k]:
            pos = cont[1]
            positions.append(pos)
        #print(positions)
        for i,pos in enumerate(grid.pieces[k]):
            if pos[0] in positions:
                grid.pieces[k][i][1]=0
                positions.remove(pos[0])
            elif pos[1]==switch:
                grid.pieces[k].remove(pos)
            else:
                grid.pieces[k][i][1]+=1
        grid.pieces[k].extend([[p,0] for p in positions])
        grid.pieces[k]=(grid.pieces[k])[:(piece_num[k])]

