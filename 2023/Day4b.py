import re

filename="Day4.txt"
with open(filename) as file:
    total=0;
    id=1
    copies={}
    for line in file:
        if id not in copies:
            copies[id]=1
        total += copies[id]
        parts =re.search(r":\s+([\d\s]*)\s+\|\s+([\d\s]*)",line)
        wins={}
        for win in re.finditer(r"(\d+)",parts.group(1)):
            wins[win.group(1)]=1
        score=0
        for n in re.finditer(r"(\d+)",parts.group(2)):
            if n.group(1) in wins:
                score +=1
        for x in range(id+1, id+score+1):
            if x in copies:
                copies[x] += copies[id]
            else:
                copies[x]=copies[id] +1
        id+=1
    print(total)
                                



    
