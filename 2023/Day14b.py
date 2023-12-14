import numpy as np

map=[]

def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))

def cycle(m):
    for i in range(0,4):
        slide_north(m)
        m = np.rot90(m,3)
    return m

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

    matches=0
    s={}
    scores=[]
    #print_map(map)
    print("")
    n=0
    while True:
        map = cycle(map)
        key = hash(map.tobytes())
        sc=score(map)
        scores.append(sc)
        if key in s:
            pattern = n-s[key]
            offs = (1000000000-n) % pattern
            print("pattern length: %s offs %s, begins at %s" %(pattern,offs, n-pattern))
            index = n-pattern+offs-1
            print("Beam loading is %s" % scores[index])
            break
        s[key] =n
        n += 1


    

        
