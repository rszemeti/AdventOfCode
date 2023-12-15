import re

def score(boxes):
    total=0
    for i,b in enumerate(boxes):
        if b:
            for k in b:
                lens=b[k]
                total += (i+1) * lens['pos'] * lens['fl']

    return total
            
    
def my_hash(w):
    h = 0
    chars=[*w]
    for c in chars:
        h += ord(c)
        h *= 17
        h = h % 256
    return h
            
with open("Day15.txt") as file:
    boxes=[None] * 256

    for line in file:
        words = line.strip().split(",")
        for word in words:
            if re.search(r"\=",word):
                cmd = word.split("=")
                box_number = my_hash(cmd[0])
                if not boxes[box_number]:
                    boxes[box_number]={}
                if cmd[0] in boxes[box_number]:
                    slot = boxes[box_number][cmd[0]]
                    slot['fl']=int(cmd[1])
                    boxes[box_number][cmd[0]]=slot
                else:
                    slot={
                        "fl": int(cmd[1]),
                        "pos": len(boxes[box_number])+1
                    }
                    boxes[box_number][cmd[0]]=slot
            elif re.search(r"\-",word):
                cmd = word.split("-")
                box_number = my_hash(cmd[0])
                if boxes[box_number] and cmd[0] in boxes[box_number]:
                    rem = boxes[box_number].pop(cmd[0])
                    pos = rem['pos']
                    for slot in boxes[box_number]:
                        if boxes[box_number][slot]['pos']>pos:
                            boxes[box_number][slot]['pos'] -= 1            
            
    print(score(boxes));




    

        
