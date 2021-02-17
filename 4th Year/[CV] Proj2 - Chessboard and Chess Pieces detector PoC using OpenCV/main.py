import cv2
import numpy as np
from geometry import *
from draw import *
from pieces import *

cam = cv2.VideoCapture(1)

img_list = []
img_ix = 0

line_list = []
line_ix = 0

cont_list = []
cont_ix = 0

kernel = np.ones((2,2), np.uint8)

lowerArea = 70
upperArea = 450

whites = Grid()
blacks = Grid(False)

mousex = mousey = 0
def mouse_callback(event, x, y, flags, params):
    global mousex, mousey

    if event == cv2.EVENT_MOUSEMOVE:
        mousex = x
        mousey = y
    if event == cv2.EVENT_LBUTTONDOWN:
        print("({},{})".format(x,y))

# Display window
cv2.namedWindow("Chessboard Detector", cv2.WINDOW_AUTOSIZE)
cv2.setMouseCallback("Chessboard Detector", mouse_callback)

chessboard = np.zeros((tile_size * 8, tile_size * 8, 4))
color = 255
for i in range(8):
    for j in range(8):
        cv2.rectangle(chessboard, (j * tile_size, i * tile_size),
                          ((j+1) * tile_size, (i+1) * tile_size), (color, color, color, 1.0), -1)
        if j != 7:
            color = 0 if color == 255 else 255

chessboard_w_pieces = chessboard.astype('uint8')

def Main():
    global img_ix, line_ix, chessboard_w_pieces

    while True:
        ret, og = cam.read()
        hei,wid,ch = og.shape

        chessboard_w_pieces = cv2.cvtColor(chessboard_w_pieces, cv2.COLOR_RGBA2RGB)

        img_list.clear()
        line_list.clear()
        cont_list.clear()

        # Conversion to Grayscale
        gray = cv2.cvtColor(og,cv2.COLOR_BGR2GRAY)
        img_list.insert(0,gray)

        # Thresholding
        ret,thresh = cv2.threshold(gray,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)
        img_list.insert(0,thresh)

        # Closing
        closed = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
        img_list.insert(0,closed)

        # Closed Negative
        n_closed = cv2.bitwise_not(closed)

        
        contours,_ = cv2.findContours(n_closed, cv2.RETR_LIST, cv2.CHAIN_APPROX_NONE)
        contours = [c for c in contours if cv2.contourArea(c)<upperArea and cv2.contourArea(c)>=lowerArea]
        c_lst = list(contours)
        
        # Canny Detection
        canny = cv2.Canny(closed, 20, 200)
        img_list.insert(0,canny)

        # Hough Lines
        lines = cv2.HoughLinesP(image=canny,rho=1.0,theta=np.pi/180,threshold=100,lines=np.array([]),minLineLength=110,maxLineGap=40)
        if lines is not None:
            lines = [line[0] for line in lines]
            line_list.append(lines)
            grid1, grid2 = grid_lines(lines,wid,hei)
            if grid1 is not None and grid2 is not None:
                grid = grid1.copy()
                grid.extend(grid2)
                line_list.append(grid)

                points = []
                for line in grid:
                    points.append([line[0],line[1]])
                    points.append([line[2],line[3]])
            
                tuned1 = select_grid_lines(grid1)
                tuned2 = select_grid_lines(grid2)
                tuned = []
                points = []
                if tuned1 is not None and tuned2 is not None:
                    tuned = tuned1.copy()
                    tuned.extend(tuned2)
                    line_list.append(tuned)
                    
                    leng = len(tuned1)

                    # points.append((int(mousex),int(mousey)))

                    tmp_cont = {get_piece_in_board(cont,tuned1,tuned2):cont for cont in c_lst}
                    w_by_pos = {k:v for k,v in tmp_cont.items() if cv2.contourArea(v,True) < 0}
                    b_by_pos = {k:v for k,v in tmp_cont.items() if cv2.contourArea(v,True) > 0}
                    white_pieces=find_all_pieces(whites,w_by_pos)
                    cont_list.insert(0,white_pieces)
                    black_pieces=find_all_pieces(blacks,b_by_pos)
                    cont_list.insert(0,black_pieces)
                    
                    if cont_ix>0 and cont_ix-1<len(cont_list):
                        cv2.drawContours(og, cont_list[cont_ix-1], -1, (255, 0, 255), 1)

                    fill_board(whites,tuned1,tuned2)
                    fill_board(blacks,tuned1,tuned2)
                    load_all_pieces(chessboard_w_pieces,whites)
                    load_all_pieces(chessboard_w_pieces,blacks)


                if line_ix>0 and line_ix-1<len(line_list):
                    draw_lines(og,line_list[line_ix-1])

                draw_points(og,points)

        #cv2.imshow('Lines', og)
        last_imx=img_ix
        if get_input()<0:
            break
        if img_ix>=len(img_list)+1:
            img_ix=len(img_list)
        if img_ix>0 and img_ix-1<len(img_list):
            cv2.imshow('Analysis', img_list[img_ix-1])
            
        elif last_imx!=img_ix:
            cv2.destroyWindow('Analysis')


        chessboard_w_pieces = cv2.cvtColor(chessboard_w_pieces, cv2.COLOR_RGBA2RGB)
        numpy_horizontal = np.hstack((og, chessboard_w_pieces))
        cv2.imshow('Chessboard Detector', numpy_horizontal)
        chessboard_w_pieces = chessboard.astype('uint8')

    cam.release()
    cv2.destroyAllWindows()

def get_input():
    global img_ix, line_ix, cont_ix

    k = cv2.waitKey(1)
    if k == ord('q'):
        return -1
    elif k == ord('t'):
        cv2.waitKey(0)
    elif k == ord('+'):
        img_ix = (img_ix+1)%(len(img_list)+1)
    elif k == ord('-'):
        img_ix = (img_ix-1)%(len(img_list)+1)
    elif k == ord('l'):
        line_ix = (line_ix+1)%(len(line_list)+1)
    elif k == ord('c'):
        cont_ix = (cont_ix+1)%(len(cont_list)+1)

    return 0

Main()