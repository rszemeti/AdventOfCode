
def score(t):
    total=0
    for r in t:
        for b in r:
            if len(b)>0:
                total+=1

    return total

dirs = {
    "L": (-1,0),
    "R": (1,0),
    "U": (0,-1),
    "D": (0,1)
}

def reflect(d,s):
    if s==".":
        return [d]
    if s=="/":
        if d=="L":
            return ["D"]
        elif d=="R":
            return ["U"]
        elif d=="D":
            return ["L"]
        else:
            return ["R"]
    if s=="\\":
        if d=="L":
            return ["U"]
        elif d=="R":
            return ["D"]
        elif d=="D":
            return ["R"]
        else:
            return ["L"]
    if s=="|":
        if d=="L":
            return ["U","D"]
        elif d=="R":
            return ["U","D"]
        else:
            return [d]
    if s=="-":
        if d=="U":
            return ["L","R"]
        elif d=="D":
            return ["L","R"]
        else:
            return [d]

def get_score(map,start):
    tracker=[]
    
    for r in map:
        tracker.append([{} for _ in range(len(map[0]))])

    beams=[]
    beams.append(start)
    tracker[start[1]][start[0]][start[2]]="#"

    while len(beams) > 0:
        beam = beams.pop()
        s = map[beam[1]][beam[0]]
        for r in reflect(beam[2],s):
            nb = (beam[0]+dirs[r][0],beam[1]+dirs[r][1],r)
            if nb[0] >= 0 and nb[0] < len(map[0]) and nb[1] >=0 and nb[1]< len(map):
                if r not in tracker[nb[1]][nb[0]]:
                    beams.append(nb)
                    tracker[nb[1]][nb[0]][r]="#"
                
    return(score(tracker))
            
with open("Day16.txt") as file:
    map=[]
    for line in file:
        map.append([*line.strip()])
    
    scores=[]
    for r in range(0,len(map)):
        scores.append(get_score(map,(0,r,"R")))
        scores.append(get_score(map,(len(map[r])-1,r,"L")))
    for r in range(0,len(map[0])):
        scores.append(get_score(map,(r,0,"D")))
        scores.append(get_score(map,(r,len(map)-1,"U")))

    print(max(scores))
        

    
    
        
