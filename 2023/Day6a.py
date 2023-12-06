import re
import math

def roots(t,d):
    r1 = (t - math.sqrt(t*t -4*d))/(2)
    r2 = (t + math.sqrt(t*t -4*d))/(2)
    p1 = math.floor(r1)+1
    p2 = math.ceil(r2)-1
    return p2-p1+1

filename="Day6b.txt"
with open(filename) as file:      
    times=[]
    dist=[]
    for t in re.finditer(r"(\d+)",file.readline()):
        times.append(int(t.group(1)))
    for d in re.finditer(r"(\d+)",file.readline()):
        dist.append(int(d.group(1)))

    result=1
    for n in range(0,len(times)):
        result *= roots(times[n],dist[n])

    print(result)
            
            


                                



    
