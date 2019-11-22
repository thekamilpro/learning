import time
time.ctime()

def banner(message, border='-'):
    line = border * len(message)
    print(line)
    print(message)
    print(line)

banner ("PowerShell is a king")

banner("Python is not, sorry", "*")

banner("Sun, Moon and  Stars", border="*")

banner(border=".", message="Hello there")


