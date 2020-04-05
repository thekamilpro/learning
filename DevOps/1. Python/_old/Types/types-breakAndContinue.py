student_names = ["James", "Katarina", "Jessica",
                 "Mark", "Bort", "Frank Grimes", "Max Power"]

# Goes through whole list
for name in student_names:
    if name == "Mark":
        print("Found him! " + name)
    print("Currently testing " + name)

# Breaks after Mark
for name in student_names:
    if name == "Mark":
        print("Found him! " + name)
        break
    print("Currently testing " + name)

# Skip code and continue executing the rest
for name in student_names:
    if name == "Bort":
        continue
        print("Found him! " + name)
    print("Currently testing " + name)
