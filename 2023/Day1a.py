import re

with open("Day1.txt") as fp:
    sum=0
    for line in fp:
        ms = re.search(r"^[a-z]*(\d)",line)
        es = re.search(r"(\d)[a-z]*$",line)
        n = int("%s%s" % (ms.group(1),es.group(1)))
        sum +=n

    print(sum)
        
