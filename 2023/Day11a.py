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
    for row in map:
        for i,cell in enumerate(row):
            if cell == "#":
                empty_cols[i]=False
    
    for i,row in enumerate(map):
        new=[]
        for y in range(0, len(row)):
            new.append(row[y])
            if empty_cols[y]:
                new.append(".")
        map[i]=new

    stars=[]
    for x,row in enumerate(map):
        for y,cell in enumerate(row):
            if cell=="#":
                stars.append((x,y))

    pairs = list(itertools.combinations(stars, 2))

    dist=0
    for pair in pairs:
        dx = abs(pair[0][0]-pair[1][0])
        dy = abs(pair[0][1]-pair[1][1])
        dist += dx+dy

    #print_map(map)
    print(dist)
        
