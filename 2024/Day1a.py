import re

with open("2024/Day1a.txt") as fp:

    a = []
    b = []

    for line in fp:
        vals = re.findall(r"\d+",line)
        a.append(int(vals[0]))
        b.append(int(vals[1]))
    
    suma = 0
    sumb = 0

    a.sort()
    b.sort()
    
    for i in range(len(a)):
        suma += abs(a[i]-b[i])
        sumb += a[i]*b.count(a[i])

    print(suma,sumb)
