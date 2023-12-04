import re

filename="Day4.txt"
with open(filename) as file:
    total=0;
    for line in file:
        parts =re.search(r":\s+([\d\s]*)\s+\|\s+([\d\s]*)",line)
        wins={}
        for win in re.finditer(r"(\d+)",parts.group(1)):
            wins[win.group(1)]=1
        score=0
        for n in re.finditer(r"(\d+)",parts.group(2)):
            if n.group(1) in wins:
                if score==0:
                    score=1
                else:
                    score *=2
        total +=score
    print(total)
                                



    
