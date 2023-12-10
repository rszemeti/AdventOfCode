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
        self.points = sorted(self.points, key=lambda x: x[1])

    def add_range(self, dest,source,span):
        self.points.append([dest,source,span])

    def get_overlap(self,a,b):
        start1= a[0]
        length1 =a[1]

        start2= b[1]
        length2 =b[2]

        end1 = start1 + length1 - 1
        end2 = start2 + length2 - 1

        overlap_start = max(start1, start2)
        overlap_end = min(end1, end2)

        if overlap_start <= overlap_end:
            overlap_length = overlap_end - overlap_start + 1
            return (overlap_start, overlap_length)
        
        return None

    # given an input range in the form (n,span)
    # returns a list of output ranges in the same form
    def map_range(self,n):
        lor =[]
        for point in self.points:
            overlap = self.get_overlap(n,point)
            if overlap:
                new = [point[0]+overlap[0]-point[1],overlap[1]]
                lor.append(new)

        if len(lor)==0:
            lor.append(n)
        return lor

def find(name,n):
    l_of_ra = maps[name].map_range(n)
    if maps[name].mapto=="location":
        return l_of_ra
    else:
        l=[]
        for ra in l_of_ra:
            l += find(maps[name].mapto,ra)
        return l

def search(items,name):
    low=None
    for n in items:
        locs =find(name,[n[0],n[1]])
        for loc in locs:
            if (low == None) or (low > loc[0]) :
                low = loc[0]
    return low
        

seeds=[]
maps={}
low=None


filename="Day5.txt"
with open(filename) as file:
    for line in file:
        if line.startswith("seeds:"):
            for s in re.finditer(r"(\d+)\s+(\d+)",line):
                seeds.append((int(s.group(1)),int(s.group(2))))
        m = re.match("(\w+)-to-(\w+)",line)
        if m:
            q = Map(m.group(1),m.group(2))
            q.proc_lines(file)
            maps[q.mapfrom] = q
            
    low = search(seeds,"seed")
            
    print("Lowest is %s" % low)
            


                                



    
