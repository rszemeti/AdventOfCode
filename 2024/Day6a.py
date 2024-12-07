import re
import numpy as np

map = []
start = (None,None)

with open("2024/Day6.txt") as fp:
    i=0
    for line in fp:
        m = list(line.strip())
        map.append(m)
        print(m)
        try:
            start = (i,m.index("^"))
        except:
            pass
        i+=1
    
dir = 2
dirs =[(1,0),(0,1),(-1,0),(0,-1)]   

while True:
    next_pos = (start[0]+dirs[dir][0],start[1]+dirs[dir][1])
    try:
        if(map[next_pos[0]][next_pos[1]] == "#"):
            dir = (dir-1)%4
        else:
            start = next_pos
            map[start[0]][start[1]] = "O"
    except:
        break

count = 0
for line in map:
    count += line.count("O")   

print (count)

            
                

                



    


