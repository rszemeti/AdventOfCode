import itertools

map=[]

def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))

with open("Day11.txt") as file:

    for line in file:
        map.append([*line.strip()])

    empty_rows = [True] * len(map) 
    empty_cols = [True] * len(map[0])
    for x in range(0,len(map)):
        for y in range(0, len(map[x])):
            if map[x][y] == "#":
                empty_cols[y]=False
                empty_rows[x]=False

    stars=[]
    for x in range(0,len(map)):
        for y in range(0, len(map[x])):
            if map[x][y]=="#":
                stars.append((x,y))

    pairs = list(itertools.combinations(stars, 2))

    dist=0
    mult=1000000
    for pair in pairs:
        dx = abs(pair[0][0]-pair[1][0]) 
        l = [pair[0][0],pair[1][0]]
        for x in range(min(l),max(l)):
            if empty_rows[x]:
                dist+=mult-1
        dy = abs(pair[0][1]-pair[1][1])
        l = [pair[0][1],pair[1][1]]
        for y in range(min(l),max(l)):
            if empty_cols[y]:
                dist+=mult-1
        dist += dx+dy

    print(dist)
        
