

map=[]

def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))

def slide_north(m):
    while(one_shuffle(m)):
        pass

def one_shuffle(m):
    changed=False
    for r in range(0,len(m)-1):
        for c in range(0,len(m[r])):
            if m[r][c]=="." and m[r+1][c]=="O":
                m[r][c]="O"
                m[r+1][c]="."
                changed=True
    return changed

def score(m):
    top = len(m)
    score=0
    for i,r in enumerate(m):
        for c in r:
            if c=="O":
                score+= top-i
    return score
                
with open("Day14.txt") as file:

    for line in file:
        map.append([*line.strip()])

    slide_north(map)
    print(score(map))

        
