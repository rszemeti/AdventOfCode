import itertools

map=[]

with open("Day12_sample.txt") as file:
    count=0

    for line in file:
        p,nstr = line.strip().split(" ")
        pattern = [*p]
        nl=[int(n) for n in nstr.split(",")]
        hash_target=sum(nl)
        
        wild_count=0
        hash_count=0
        wild_map=[]
        for i,c in enumerate(pattern):
            if c=="?":
                wild_count += 1
                wild_map.append(i)
            elif c=="#":
                hash_count += 1

        need = hash_target-hash_count

        
        print(pattern)
        print(wild_count,hash_count,hash_target)
    print(count)
        


        
