import re
import numpy as np

def find_pattern(vals,i,j,search,pattern,rotation):
    # first rotate the pattern
    np_pattern = np.array(pattern)
    np_pattern = np.rot90(np_pattern,rotation//90)
    # now we can check the pattern
    for pi in range(0,3):
        for pj in range(0,3):
            if np_pattern[pi][pj] == '*':
                continue
            if vals[i-1+pi][j-1+pj] != np_pattern[pi][pj]:
                return False
    return True


with open("2024/Day4.txt") as fp:

    vals = []
    ansa=0

    search = list("MAS")
    pattern = [
        ['M','*','S'],
        ['*','A','*'],
        ['M','*','S'],
    ]

    for line in fp:
        vals.append(list(line.strip()))


    # we need a non edge case, so inc 1 and dec 1 from the range
    for i in range(1,len(vals)-1):
        for j in range(1,len(vals[i])-1):
            if vals[i][j] == search[1]:
                #we found an A
                if find_pattern(vals,i,j,search,pattern,0):
                    ansa += 1
                elif find_pattern(vals,i,j,search,pattern,90):
                    ansa += 1
                elif find_pattern(vals,i,j,search,pattern,180):
                    ansa += 1
                elif find_pattern(vals,i,j,search,pattern,270):
                    ansa += 1

                

                



    
print(ansa)

