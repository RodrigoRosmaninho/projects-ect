import math

def grid_lines(lines,wid,hei):
    lines1 = []
    lines2 = []
    delta = 30
    if lines is not None:
        for edge in lines:
            line, t = line_extreme(edge,wid,hei)
            if line is not None:
                if t == 0:
                    if not any([max(line[1]-l[1],l[1]-line[1])<delta for l in lines1]):
                        lines1.append(line)
                elif t == 1:
                    if not any([max(line[0]-l[0],l[0]-line[0])<delta for l in lines2]):
                        lines2.append(line)
    lines1.sort(key=lambda l:l[1])
    lines2.sort(key=lambda l:l[0])
    return lines1, lines2

def line_extreme(line,wid,hei):
    angle = line_angle(line)
    t = 0
    if angle >= 45 and angle <= 135:
        t = 1
        xtreme1 = line_intersection(line,[0,0,wid,0])
        xtreme2 = line_intersection(line,[0,hei,wid,hei])
    else:
        xtreme1 = line_intersection(line,[0,0,0,hei])
        xtreme2 = line_intersection(line,[wid,0,wid,hei])
    if xtreme1 is None or xtreme2 is None:
        return None, None
    return ([xtreme1[0], xtreme1[1], xtreme2[0], xtreme2[1]],t)

def line_intersection(l1, l2):
    line1=l1
    line2=l2

    x1=line1[0]
    y1=line1[1]
    x2=line1[2]
    y2=line1[3]

    x3=line2[0]
    y3=line2[1]
    x4=line2[2]
    y4=line2[3]

    den = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4)
    if den == 0:
        return None
    px = ((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4)) / den
    py = ((x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4)) / den
    return (round(px),round(py))

# get coordinate in line given another
def get_coord(line,x=None,y=None):
    if x==None and y==None:
        return None
    tmp=(line[2]-line[0])
    if tmp==0:
        if x==None:
            return line[2]
        if y==None:
            return None if x!=line[2] else line[2]
    else:
        m=(line[3]-line[1])/(line[2]-line[0])
        b=line[3]-m*line[2]

        if x==None:
            return (y-b)/m
        if y==None:
            return m*x+b
    return None

# get position in grid
def get_pos_in_grid(grid1,grid2,x,y):
    col=row=0
    for i in range(len(grid1)):
        gridcol=get_coord(grid2[i],None,y)
        gridrow=get_coord(grid1[i],x,None)
        if gridcol<x:
            col+=1
        if gridrow<y:
            row+=1
        
    return col,row


def line_angle(line):
    angle = math.atan2(line[1]-line[3],line[0]-line[2])
    angle = math.degrees(angle)
    if angle<0:
        angle+=180
    return angle

def select_grid_lines(lines):
    linenum = 7

    ret = lines.copy()
    leng = len(lines)
    if leng < linenum:
        return None
    mid = int(leng/2)

    list1=list(range(mid,leng))
    list2=list(range(0,mid))
    list2.reverse()
    num = min(len(list1), len(list2))
    result = [None]*(num*2)
    result[::2] = list1[:num]
    result[1::2] = list2[:num]
    result.extend(list1[num:])
    result.extend(list2[num:])
    result.reverse()
    for i in result:
        if len(ret) > linenum:
            ret.remove(lines[i])
        else:
            break
    return ret
