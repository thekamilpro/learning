def banner(message, border='-'):
    line = border * len(message)
    print(line)
    print(message)
    print(line)

banner ("PowerShell is a king")

banner("Python is not, sorry", "*")
