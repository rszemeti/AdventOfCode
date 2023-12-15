
def my_hash(w):
    h = 0
    chars=[*w]
    for c in chars:
        h += ord(c)
        h *= 17
        h = h % 256
    return h
              
with open("Day15.txt") as file:
    total=0
    for line in file:
        words = line.strip().split(",")
        for word in words:
            total += my_hash(word)

    print(total)




    

        
