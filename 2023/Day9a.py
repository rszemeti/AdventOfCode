def extend(nums):
    diffs=[]
    for i in range(1,len(nums)):
        diffs.append(nums[i] - nums[i-1])

    all_zero=True
    for i in range(0,len(diffs)):
        if diffs[i] != 0:
            all_zero=False
            break
    n=None;
    if not all_zero:
        n = extend(diffs)
    else:
        n =0
    return n+int(nums[-1]) 

filename="Day9.txt"
with open(filename) as file:
    score=0
    for line in file:
        nums = [int(i) for i in line.split()]
        score += extend(nums)
    print(score)
       
            


                                



    
