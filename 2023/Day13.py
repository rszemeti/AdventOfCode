def print_map(m):
    for x in range(0,len(m)):
        print("".join(m[x]))
    print("")

def proc(m,diffs):
    v =find_v(m,diffs)
    if v:
        return v
    else:
        h = find_h(m,diffs)
        if h:
            return 100*h
        
def find_v(m,diffs):
    for i in range(0,len(m[0])-1):
        d=0
        cells = min(i+1,len(m[0])-i-1)
        for r in map:
            for offs in range(1,cells+1):
                if(r[i-offs+1]!=r[i+offs]):
                    d += 1
        if d==diffs:
            return i+1

def find_h(m,diffs):
    for i in range(0,len(m)-1):
        d = 0
        cells = min(i+1,len(m)-i-1)
        for col in range(0,len(m[0])):
            for offs in range(1,cells+1):
                if(m[i-offs+1][col]!=m[i+offs][col]):
                    d +=1
                
        if d==diffs:
            return i+1

with open("Day13.txt") as file:
    smudges=1
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
        


        
