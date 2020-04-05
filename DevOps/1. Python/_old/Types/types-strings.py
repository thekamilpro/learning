'Hello World' == "Hello World" == """Hello World"""
"hello".capitalize() == "Hello"
"hello".replace("e", "a") == "hallo"
"hello".isalpha() == True
"123".isdigit() == True #Useful when converting to int
"some,csv,values".split(",") == ["some", "csv", "value"]

"Nice to meet you {0}. I am {1}".format(name, machine)

f"Nice to meet you {name}. I am {machine}" #string interpolation