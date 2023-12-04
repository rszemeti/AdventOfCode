import re

m = {}
with open("Day3.txt") as file:
    r=0
    for line in file:
        if r not in m:
            m[r]={}
        c=0
        for char in re.finditer(r"(.)",line):
            match = re.match(r"[^\.\d]",char.group(1))
            if match:
                for x in range(r-1,r+2):
                    if x not in m:
                        m[x]={}
                    for y in range(c-1,c+2):
                        if (x>=0) & (y>=0):
                            m[x][y]=1
            c += 1
        r += 1

with open("Day3.txt") as file:
    sum = 0
    r=0
    for line in file:
        for part in re.finditer(r"(\d+)",line):
            flag= False
            for c in range(part.span()[0],part.span()[1]):
                if c in m[r]:
                    flag = True
                    break
            if(flag):
                sum += int(part.group(1))
            else:
                print(part.group(1))
        r+=1

    print(sum)
    
