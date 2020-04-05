#for Loop
student_names = ["Mark", "Katarina", "Jessica"]

for name in student_names:
    print("Student name is {0}".format(name))

x = 0
for index in range(10):
    x += 10
    print("The value of X is {0}".format(x))

range(5,10) == [5,6,7,8,9] #start range from 5

range(5,10,2) == [5,7,9,11] #start range from 5, increment value by 2