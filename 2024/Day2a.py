import re

def direction(val1,val2):
    if val1 < val2:
        return "up"
    else:
        return "down"

with open("2024/Day2.txt") as fp:

    ansa=0

    for line in fp:
        vals = list(map(int,re.findall(r"\d+",line)))
        dir = direction(vals[0],vals[1])    
        for i in range(len(vals)-1):
            is_safe = True
            if direction(vals[i],vals[i+1]) != dir:
                is_safe = False 
                break
            if  not(1 <= abs(vals[i]-vals[i+1]) <= 3):
                is_safe = False
                break
        if is_safe:
            print(vals, "safe")
            ansa += 1
        else:
            print(vals, "unsafe")
    
print(ansa)

