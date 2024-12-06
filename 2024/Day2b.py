import re

def direction(val1,val2):
    if val1 < val2:
        return "up"
    else:
        return "down"

def test_safety(vals):
    dir = direction(vals[0],vals[1])    
    for i in range(len(vals)-1):
        if direction(vals[i],vals[i+1]) != dir:
            return False
        if  not(1 <= abs(vals[i]-vals[i+1]) <= 3):
            return False
    return True

with open("2024/Day2.txt") as fp:

    ansa=0

    for line in fp:
        vals = list(map(int,re.findall(r"\d+",line)))
        safe = test_safety(vals)
        if not safe:
            for i in range(len(vals)):
                vals2 = vals.copy()
                vals2.pop(i)
                safe = test_safety(vals2)
                if safe:
                    ansa += 1
                    break
        else:
            ansa += 1

    
print(ansa)

