import re

with open("2024/Day3.txt") as fp:

    ansa=0

    for line in fp:
        muls = re.findall(r"mul\(\d+,\d+\)",line)
        for mul in muls:
            vals = list(map(int,re.findall(r"\d+",mul)))
            ansa += vals[0]*vals[1]
    
print(ansa)

