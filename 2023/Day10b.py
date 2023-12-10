map=[]
track=[]

dirs = {
    "U": [-1,0],
    "D": [1,0],
    "L": [0,-1],
    "R": [0,1]
}

right = {
    "U": [0,1],
    "D": [0,-1],
    "L": [-1,0],
    "R": [1,0]
}

left = {
    "U": [0,-1],
    "D": [0,1],
    "L": [1,0],
    "R": [-1,0]
}

pipes = {
    "F": {"U": "R", "L": "D"},
    "-": {"L": "L", "R": "R"},
    "7": {"R": "D", "U": "L"},
    "|": {"U": "U", "D": "D"},
    "J": {"D": "L", "R": "U"},
    "L": {"L": "U", "D": "R"},
    ".": {}
}

def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))



def move(curDir, curLoc, t):
    curLoc[0]=curLoc[0]+dirs[curDir][0]
    curLoc[1]=curLoc[1]+dirs[curDir][1]
    if t:
        t[curLoc[0]][curLoc[1]]=map[curLoc[0]][curLoc[1]]
        t[curLoc[0]][curLoc[1]]="X"
    c = map[curLoc[0]][curLoc[1]]
    if c == "S":
        return False
    else:
        globals()['curDir'] = pipes[c][curDir]
        return True
    
def mark(curDir, curLoc, t, rule):
    # mark cell on way in 
    rx = curLoc[0]+rule[curDir][0]
    ry = curLoc[1]+rule[curDir][1]
    if(rx >= 0 and rx < len(t)) and (ry >= 0 and ry < len(t[rx])):
        if t[rx][ry]==".":
            t[rx][ry]="I"
    pmd = curDir
    m = move(curDir, curLoc, None)
    if pmd != globals()['curDir']:
        rx = curLoc[0]+rule[curDir][0]
        ry = curLoc[1]+rule[curDir][1]
        if(rx >= 0 and rx < len(t)) and (ry >= 0 and ry < len(t[rx])):
            if t[rx][ry]==".":
                t[rx][ry]="I"
        
    return m
    
def fill(t):
    changed=False
    for x in range(0,len(t)):
        #fill left to right
        for y in range(0,len(t[x])-1):
            if t[x][y]=="I":
                if t[x][y+1]==".":
                    #print("Changing %s,%s" % (x,y))
                    t[x][y+1]="I"
                    changed=True              
    return changed

def count_chars(c,t):
    count = 0
    for x in range(0,len(t)):
        for y in range(0,len(t[x])):
            if t[x][y]== c:
                count +=1
    return count
                
    

filename="Day10.txt"
with open(filename) as file:
    for line in file:
        map.append([*line.strip()])
        track.append(["."]*len(map[0]))

    # find start point 
    s=None
    for x in range(0,len(map)):
        for y in range(0,len(map[x])):
            if map[x][y]=="S":
                s=[x,y]
                break

    curDir=None
    curLoc=s
    #find initial direction to move
    for d in ["U","D","L","R"]:
        tx = s[0]+dirs[d][0]
        ty = s[1]+dirs[d][1]
        c = map[tx][ty]
        if d in pipes[c]:
            curDir=d
            
    #run around the perimeter and mark the track.
    initDir=curDir     

    while move(curDir,curLoc,track):
        pass

    #run around the track marking any inner points
    curLoc=s
    curDir=initDir
    while mark(curDir,curLoc,track,left):
        pass

    # fill in  
    while(fill(track)):
        pass
    
    #print_map(track)

    print(count_chars("I",track))

    





            
            


                                



    
