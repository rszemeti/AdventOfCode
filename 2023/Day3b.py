import re

m = {}
mult={}
filename="Day3.txt"
with open(filename) as file:
    r=0
    for line in file:
        if r not in m:
            m[r]={}
            mult[r]={}
        c=0
        for part in re.finditer(r"(\d+)",line):
            for x in range(r-1,r+2):
                if x not in m:
                    m[x]={}
                    mult[x]={}
                for y in range(part.span()[0]-1,part.span()[1]+1):
                    if (x>=0) & (y>=0):
                        if y in m[x]:
                            m[x][y] += 1
                            mult[x][y] *= int(part.group(1))
                        else:
                            m[x][y] = 1
                            mult[x][y] = int(part.group(1))        
            c += 1
        r += 1

with open(filename) as file:
    sum = 0
    r=0
    for line in file:
        for part in re.finditer(r"\*",line):
            if m[r][part.span()[0]]==2:
                sum += mult[r][part.span()[0]]
        r+=1

    print(sum)
    
