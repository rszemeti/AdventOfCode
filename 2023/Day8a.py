import re

cmds=[]
map={}

filename="Day8.txt"
with open(filename) as file:
    cmds = [*file.readline().strip()]

    for line in file:
        m = re.match("^(\w+).*\((\w+),\s(\w+)\)",line)
        if(m):
            map[m.group(1)] = {"L": m.group(2), "R": m.group(3)}

    p=0
    c=1
    node='AAA'
    while True:
        if c>1000000:
            print("failed")
            break
        node=map[node][cmds[p]]
        #print("turned %s, got %s" % (cmds[p],node))
        if node == "ZZZ":
            print(c)
            break;
        p+=1
        c+=1
        if p == len(cmds):
            p=0
        

            
            


                                



    
