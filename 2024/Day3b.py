import re

with open("2024/Day3.txt") as fp:

    ansa=0

    do = True

    for line in fp:
        muls = re.findall(r"mul\(\d+,\d+\)|do\(\)|don't\(\)",line)
        for mul in muls:
            print(mul)
            if("don't" in mul):
                do = False
            elif("do" in mul):
                do = True
            elif ("mul" in mul):
                if do:
                    vals = list(map(int,re.findall(r"\d+",mul)))
                    ansa += vals[0]*vals[1]
    
print(ansa)

