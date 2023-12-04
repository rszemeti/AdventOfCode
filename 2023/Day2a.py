import re

test = {
    'red': 12,
    'green': 13,
    'blue': 14
}

with open("Day2.txt") as file:
    sum=0
    for line in file:
        g = re.search(r"^Game (\d+)",line)
        game = int(g.group(1))
        line=re.sub(r"^Game.+:\s",'',line)
        print(line)
        for pair in re.finditer(r"(\d+)\s(red|green|blue)",line):
            if int(pair.group(1)) > test[pair.group(2)]:
                game=0
        sum += game

    print(sum)
        
