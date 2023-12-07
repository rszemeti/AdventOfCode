import re

class Hand:

    tests = [
        (5,7),
        (4,6),
        (3,4),
        (2,2),
        (1,1)
    ]
    def __init__(self, cards, bid):
        self.scores ={}
        self.score=None
        self.cards = cards
        self.bid = int(bid)
        for card in self.cards:
            if card in self.scores:
                self.scores[card]+= 1
            else:
                self.scores[card] = 1
        if "J" in self.scores:
            jokers = self.scores["J"]
            self.scores.pop("J")
            if(len(self.scores) >0):
                m = max(self.scores, key=self.scores.get)
                self.scores[m]+=jokers
            else:
                # handle five jokers edge case
                self.scores["J"]=5
        self.assess()

    def find_kind(self,n,s):
        count=0
        for k in self.scores:
            if self.scores[k]==n:
                if self.score==None:
                    self.score=s
                count +=1
                
        return count
                
    def assess(self):
        for test in self.tests:
            self.find_kind(test[0],test[1])
            if self.score:
                break
            
        # see if 3ofkind can be elevated to full house
        if self.score==4:
            if self.find_kind(2,None):
                self.score=5
        # and check if 1 pair can be elevated to two pair
        elif self.score==2:
            if self.find_kind(2,None)==2:
                self.score=3
        
def beats(h1,h2):
    if(h1.score > h2.score):
        return True
    if(h1.score == h2.score):
        return tiebreak(h1.cards,h2.cards)
    return False

values = {
    "A": 14,
    "K": 13,
    "Q": 12,
    "J": 0,
    "T": 10,
    "9": 9,
    "8": 8,
    "7": 7,
    "6": 6,
    "5": 5,
    "4": 4,
    "3": 3,
    "2": 2,
    "1": 1
}

def tiebreak(c1,c2):
    for n in range(0,5):
        if (values[c1[n]] > values[c2[n]]):
            return True
        elif (values[c1[n]] < values[c2[n]]):
            return False
    return False
    
        
hands=[]
filename="Day7.txt"
with open(filename) as file:      

    for line in file:
        m = re.match("^(\w+)\s+(\d+)",line)
        if(m):
            hands.append(Hand(m.group(1),m.group(2)))

    total=0
    for h1 in hands:
        h1.rank = sum(beats(h1,h2)for h2 in hands)+1
        total+= h1.bid * h1.rank

    print(total)

            
            


                                



    
