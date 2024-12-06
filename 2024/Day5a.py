import re
import numpy as np

def check_rules(rules,update):
    OK = True
    for page in update:
        page_index = update.index(page) 

        for rule in rules:
            if page == rule[0]:
                try:
                    page2_index = update.index(rule[1])
                    if page2_index < page_index:
                        OK = False
                        break
                except:
                    pass
    return OK

def reorder(rules,update):
    for page in update:
        page_index = update.index(page) 

        for rule in rules:
            if page == rule[0]:
                try:
                    page2_index = update.index(rule[1])
                    if page2_index < page_index:
                        update[page_index],update[page2_index] = update[page2_index],update[page_index]
                        break
                except:
                    pass

def mid_value(update):
    return int(update[ (len(update)-1)//2 ])


with open("2024/Day5.txt") as fp:

    rules = []
    updates = []

    for line in fp:
        if line.strip() == "":
            break
        rules.append(line.strip().split("|"))
    
    for line in fp:
        updates.append(line.strip().split(","))
    
ansa=0
ansb=0

for update in updates:
    if check_rules(rules,update):
        ansa += mid_value(update)
    else:
        while not check_rules(rules,update):
            reorder(rules,update)
        ansb += mid_value(update)

print(ansa)
print(ansb)

            
                

                



    


