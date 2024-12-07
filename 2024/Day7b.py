import re

def numberToBase(n, b):
    if n == 0:
        return [0]
    digits = []
    while n:
        digits.append(int(n % b))
        n //= b
    return digits[::-1]

def check(test,args):
    print("Checking",test,args)
    p = len(args)-1
    n = 3**p
    for i in range(n):
        txt = bin(i)[2:].zfill(p)
        operators = numberToBase(i,3)
        while(len(operators)<p):
            operators.insert(0,0)
        # combine the operators and args
        result = int(args[0])
        for i in range(1,len(args)):
            if(operators[i-1]==0):
                result += int(args[i])
            elif(operators[i-1]==1):
                result = int(str(result) + args[i])
            else:
                result *= int(args[i])
        if(result==test):
            return True
        


with open("2024/Day7.txt") as fp:

    ansa=0

    for line in fp:
        test,txt = line.strip().split(": ")
        test = int(test)
        args = txt.split(" ")
        if(check(test,args)):
            ansa+=test 
    
print(ansa)

