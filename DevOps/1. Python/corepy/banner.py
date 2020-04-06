def banner(message, border='-'):
    line = border * len(message)
    print(line)
    print(message)
    print(line)

banner("Norwegian Blue") #uses default Border parameter

banner("Sun, Moon, Starts", '*') #uses * as parameter