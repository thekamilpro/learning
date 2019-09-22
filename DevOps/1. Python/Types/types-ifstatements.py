number = 5
if number == 5:
    print ("Number is 5")
else:
    print("Number is NOT 5")

text = "Python"
if text:
    print("Text is defined and truthy")

number = 5
if number != 5:
    print("This will not execute")

python_course = True
if not python_course:
    print("This will also not execute")

#multiple conditions
number = 3
python_course = True
if number == 3 and python_course:
    print("This will execute")

if number == 17 or python_course:
    print ("This will also execute")

#ternary if statements
a = 1
b = 2
"bigger" if a > b else "smaller"