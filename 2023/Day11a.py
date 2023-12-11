import itertools

map=[]

def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))

with open("Day11.txt") as file:

    for line in file:
        map.append([*line.strip()])
        if not "#" in line:
            map.append([*line.strip()])

    empty_cols=[True] * len(map)
    for x in range(0,len(map)):
        for y in range(0, len(map[x])):
            if map[x][y] == "#":
                empty_cols[y]=False
    
    for x in range(0,len(map)):
        new=[]
        for y in range(0, len(map[x])):
            new.append(map[x][y])
            if empty_cols[y]:
                new.append(".")
        map[x]=new

    stars=[]
    for x in range(0,len(map)):
        for y in range(0, len(map[x])):
            if map[x][y]=="#":
                stars.append((x,y))

    pairs = list(itertools.combinations(stars, 2))

    dist=0
    for pair in pairs:
        dx = abs(pair[0][0]-pair[1][0])
        dy = abs(pair[0][1]-pair[1][1])
        dist += dx+dy

    #print_map(map)
    print(dist)
        
