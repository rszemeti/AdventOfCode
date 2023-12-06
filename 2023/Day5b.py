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

    def map(self,n):
        for point in self.points:
            #print("n is %s" % n)
            #print(point)
            if(n >= point[1]) & (n <= point[1]+point[2]):
                d = point[0] + n - point[1]
                #print("found %s" % d)
                return d

        #print("not found %s" % n)
        return n

    # given an input range in the form (dest,(n,span))
    # returns list output ranges in the same form
    def map_range(self,n):
        print(n)
        lor =[]
        offs=0
        
        for point in self.points:
            print(point)
            pointer = n[1]+offs
            start_p = point[1]
            end_p = point[1]+point[2]-1
            start_n= n[1]+offs
            end_n = n[1]+n[2]
            ol_start=max(start_p,start_n)
            ol_end=min(end_p,end_n)
            span=ol_end-ol_start
            print("pointer is %s, start is %s and end is %s" % (pointer, start_p,end_p))
            if(pointer >= start_p) & (pointer <= end_p ):
                print("pointer in range, from %s to %s, span %s" % (ol_start,ol_end,span))
                if ol_start>pointer:
                    #add padding of 1:1 mapping of the right length
                    print("adding padding")
                    lor.append((pointer, pointer, ol_start-pointer))
                
                lor.append((n[0]+offs, start_n, span))  

        #print("not found %s" % n)
        if len(lor)==0:
            lor.append(n)
        return lor

def find(name,n):
    #print("%s, %s" % (name,n))
    l_of_ra = maps[name].map_range(n)
    if maps[name].mapto=="location":
        return l_of_ra
    else:
        l=[]
        for ra in l_of_ra:
            l.append(find(maps[name].mapto,ra))
        return l

def search(items,name):
    low=None
    for n in items:
        locs =find("seed",(n[0],n[0],n[1]))
        print(len(locs))
        for loc in locs:
            if (low == None) or (low > loc[0]) :
                low = loc[0]
    return low
        

seeds=[]
maps={}
low=None


filename="Day5_sample.txt"
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
            
    print(low)
            


                                



    
