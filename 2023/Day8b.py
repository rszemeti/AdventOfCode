import re
from math import gcd

cmds=[]
map={}
ghosts=[]

def find_distance(node):
    p=0
    c=1
    while True:
        node=map[node][cmds[p]]
        #print("turned %s, got %s" % (cmds[p],node))
        if node.endswith("Z"):
            print(c)
            return c
        p+=1
        c+=1
        if p == len(cmds):
            p=0

filename="Day8.txt"
with open(filename) as file:
    cmds = [*file.readline().strip()]

    for line in file:
        m = re.match("^(\w+).*\((\w+),\s(\w+)\)",line)
        if(m):
            map[m.group(1)] = {"L": m.group(2), "R": m.group(3)}

    for n in map:
        if n.endswith("A"):
            ghosts.append(find_distance(n))
 
    lcm = 1
    for i in ghosts:
        lcm = lcm*i//gcd(lcm, i)
    print(lcm)


        

            
            


                                



    
