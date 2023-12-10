map=[]
dirs = {
    "U": [-1,0],
    "D": [1,0],
    "L": [0,-1],
    "R": [0,1]
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

def move(curDir, curLoc):
    curLoc[0]=curLoc[0]+dirs[curDir][0]
    curLoc[1]=curLoc[1]+dirs[curDir][1]
    c = map[curLoc[0]][curLoc[1]]
    if c == "S":
        return False
    else:
        globals()['curDir'] = pipes[c][curDir]
        return True   

filename="Day10.txt"
with open(filename) as file:
    for line in file:
        map.append([*line.strip()])
        
    s=None
    for x in range(0,len(map)):
        for y in range(0,len(map[x])):
            if map[x][y]=="S":
                s=[x,y]
                break

    print(s)
    curDir=None
    curLoc=s
    #find initial direction to move
    for d in ["U","D","L","R"]:
        tx = s[0]+dirs[d][0]
        ty = s[1]+dirs[d][1]
        c = map[tx][ty]
        if d in pipes[c]:
            curDir=d
            
    len=1
    while move(curDir,curLoc):
        len +=1

    print(len/2)
    





            
            


                                



    
