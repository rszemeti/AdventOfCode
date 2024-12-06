import re

def check(vals,i,j,di,dj,search):
    # we only get here if X was already fonud so idx =1 is fine
    search_index = 1
    while True:
        i += di
        j += dj

        if i < 0 or i >= len(vals) or j < 0 or j >= len(vals[i]):
            return False
        if vals[i][j] == search[search_index]:
            search_index += 1
            if search_index == len(search):
                return True
        else:
            return False

with open("2024/Day4.txt") as fp:

    vals = []
    ansa=0

    search = list("XMAS");

    for line in fp:
        vals.append(list(line.strip()))

    for i in range(len(vals)):
        for j in range(len(vals[i])):
            if vals[i][j] == search[0]:
                # down
                if(check(vals,i,j, +1,0,search)):
                    ansa += 1
                # up
                if(check(vals,i,j, -1,0,search)):
                    ansa += 1
                # right
                if(check(vals,i,j, 0,+1,search)):
                    ansa += 1
                # left
                if(check(vals,i,j, 0,-1,search)):
                    ansa += 1
                # down right    
                if(check(vals,i,j, +1,+1,search)):
                    ansa += 1
                # down left
                if(check(vals,i,j, +1,-1,search)):
                    ansa += 1
                # up right
                if(check(vals,i,j, -1,+1,search)):
                    ansa += 1
                # up left
                if(check(vals,i,j, -1,-1,search)):
                    ansa += 1

    
print(ansa)

