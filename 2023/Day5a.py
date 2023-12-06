import re

class Map:
    def __init__(self, mf, mt):
        self.mapfrom = mf
        self.mapto = mt
        self.points = []

    def proc_lines(self,file):
        for line in file:
            m = re.match(r"(\d+)\s+(\d+)\s+(\d+)",line)
            if m:
                self.add_range(int(m.group(1)),int(m.group(2)),int(m.group(3)))
            else:
                break

    def add_range(self, s,d,span):
        self.points.append([s,d,span])

    def map(self,n):
        for point in self.points:
            if(n >= point[1]) & (n <= point[1]+point[2]):
                d = point[0] + n - point[1]
                return d
        return n

def find(name,n):
    loc = maps[name].map(n)
    if maps[name].mapto=="location":
        return loc
    else:
        return find(maps[name].mapto,loc)

def search(items,name):
    low=None
    for n in items:
        loc =find("seed",n)
        if (low == None) or (low > loc) :
            low = loc
    return low
        

seeds=[]
maps={}

filename="Day5.txt"
with open(filename) as file:
    for line in file:
        if line.startswith("seeds:"):
            for s in re.finditer(r"(\d+)",line):
                seeds.append(int(s.group(1)))
        m = re.match("(\w+)-to-(\w+)",line)
        if m:
            q = Map(m.group(1),m.group(2))
            q.proc_lines(file)
            maps[q.mapfrom] = q
            
    print(search(seeds,"seed"))
            
            


                                



    
