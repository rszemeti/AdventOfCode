import numpy as np

def proc(m,diffs):
    v =find_symmetry(m,diffs)
    if v:
        return v
    else:
        h = find_symmetry(np.transpose(m),diffs)
        if h:
            return 100*h
        
def find_symmetry(m,diffs):
    for i in range(0,len(m[0])-1):
        d=0
        cells = min(i+1,len(m[0])-i-1)
        for r in m:
            for offs in range(1,cells+1):
                if(r[i-offs+1]!=r[i+offs]):
                    d += 1
        if d==diffs:
            return i+1

with open("Day13.txt") as file:
    smudges=0 # 0 for pt1, 1 for pt2
    map = []
    total=0
    for line in file:
        if line.strip():
            map.append([*line.strip()])
        else:
            total+=proc(map,smudges)
            map=[]
    total+=proc(map,smudges)
    print(total)
        


        
