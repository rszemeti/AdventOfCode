import re
import numpy as np
from copy import deepcopy as deeepcopy

dirs =[(1,0),(0,1),(-1,0),(0,-1)]   

def check(pos,orig,init):
    map = deeepcopy(orig)
    # place an obstacle at the starting position
    map[pos[0]][pos[1]] = "#"
    # create a blank path log
    path = []       
    for k in map:
        row = []
        for l in k:
            row.append([])
        path.append(row)
    
    cur_pos = init

    dir=2
    while True:
        next_pos = (cur_pos[0]+dirs[dir][0],cur_pos[1]+dirs[dir][1])
        if next_pos[0] < 0:
            break
        if next_pos[1] < 0:
            break

        try:
            if((map[next_pos[0]][next_pos[1]] == "#")):
                # turn right, we hit an obstacle or our own path
                dir = (dir-1)%4
            else:
                # check if we have been here before traveling in this direction
                if dir in path[cur_pos[0]][cur_pos[1]]:
                    return True
                else:
                    #mark our path and record the direction we took to get here in our path log
                    path[cur_pos[0]][cur_pos[1]].append(dir)
                    map[cur_pos[0]][cur_pos[1]] = "*"
                    #move forward
                    cur_pos = next_pos
        except:
            break
    return False

map = []
start = (None,None)

with open("2024/Day6.txt") as fp:
    i=0
    for line in fp:
        m = list(line.strip())
        map.append(m)
        try:
            start = (i,m.index("^"))
        except:
            pass
        i+=1
    
count=0

if True:
    for i in range(len(map)):
        for j in range(len(map[0])):
            if map[i][j] == ".":
                if check((i,j),map,start):
                    count += 1

print (count)

            
                

                



    


