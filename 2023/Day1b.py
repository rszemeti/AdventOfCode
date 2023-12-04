import re

nums = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
}

sum=0
with open("Day1.txt") as fp:
    for line in fp:
        for a in nums:
            line=re.sub(r""+a,a+str(nums[a])+a,line)
        ms = re.search(r"^[a-z]*(\d)",line)
        es = re.search(r"(\d)[a-z]*$",line)
        n = int("%s%s" % (ms.group(1),es.group(1)))
        sum +=n

    print(sum)
        
