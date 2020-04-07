range(5)
#On console: range(0, 5)

for i in range(5):
    print(i)

range(5, 10)
#On console: range(5, 10)

#count from 0 to 10 by 2 
list(range(0,10,2)) 
#[0, 2, 4, 6, 8]

#iterating
print('Iterating')
t = [6, 372, 8862, 148800, 2096886]
for p in enumerate(t):
    print(p)