students = []

def read_file():
    try:
        f = open("students.txt", "r")
        for student in f.readlines():
            students.append(student)
        f.close
    except Exception:
        print("Could not read file")

read_file()
print(students)

def read_students(f):
    for line in f:
        yield line