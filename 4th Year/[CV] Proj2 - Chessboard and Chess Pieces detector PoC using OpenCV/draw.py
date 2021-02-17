import cv2
import numpy as np
from pieces import *

def draw_lines(image,lines):
    if lines is not None:
        a=len(lines)
        for i in range(a):
            cv2.line(image,(lines[i][0],lines[i][1]), (lines[i][2],lines[i][3]),(0,255,0),2,cv2.LINE_AA)


def draw_points(image,points):
    if points is not None:
        for p in points:
            cv2.circle(image, (p[0], p[1]), 5, (0,0,255), cv2.FILLED)

def draw_rectangle(image,rectangle):
    if rectangle is not None:
        cv2.rectangle(image, (rectangle[0], rectangle[1]), (rectangle[2], rectangle[3]), (0,255,255), cv2.FILLED)

def blend(underlay, overlay):
    overlay_img = overlay[:,:,:3]
    overlay_mask = overlay[:,:,3:]

    background_mask = 255 - overlay_mask

    overlay_mask = cv2.cvtColor(overlay_mask, cv2.COLOR_GRAY2BGR)
    background_mask = cv2.cvtColor(background_mask, cv2.COLOR_GRAY2BGR)

    face_part = (underlay * (1 / 255.0)) * (background_mask * (1 / 255.0))
    overlay_part = (overlay_img * (1 / 255.0)) * (overlay_mask * (1 / 255.0))
   
    return np.uint8(cv2.addWeighted(face_part, 255.0, overlay_part, 255.0, 0.0))

def load_piece(image, name, col, x_offset, y_offset):

    s_img = cv2.imread("gfx/Chess_" + name + col + "t60.png", cv2.IMREAD_UNCHANGED)

    y1, y2 = y_offset, y_offset + s_img.shape[0]
    x1, x2 = x_offset, x_offset + s_img.shape[1]

    alpha_s = s_img[:, :, 3] / 255.0
    alpha_l = 1.0 - alpha_s

    crop = image[y1:y2,x1:x2]

    res = blend(crop,s_img)

    image[y1:y2,x1:x2] = res

def load_all_pieces(image,board):
    for piece,pos in board.pieces.items():
        if piece in ['p','r','n','b','q','k']:
            for p in pos:
                xx=p[0][0]*tile_size
                yy=p[0][1]*tile_size
                load_piece(image,piece,board.col,xx,yy)