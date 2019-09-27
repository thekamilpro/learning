students = []

def get_students_titlecase():
    students_titlecase = []
    for student in students:
        students_titlecase = student["name"].title()
    return students_titlecase

def print_students_titlecase():
    students_titlecase = get_students_titlecase()
    print(students_titlecase)

def add_student(name, student_id=332):
    student = {"name": name, "student_id": student_id}
    students.append(student)

def save_file(student):
    try:
        f = open("students.txt", "a") #w = writing; overwrite file; r = reading a text file; a = appending to a file; rb = read a binary file; wb = writing to a binary file
        f.write(student + "\n")
        f.close() #file must be closed to prevent memory leaks
    except Exception:
        print("Could not save file")

def read_file():
    try:
        f = open("students.txt", "r")
        for student in f.readlines():
            add_student(student)
        f.close()
    except Exception:
        print("Could not read file")
    
student_list = get_students_titlecase()

#Read-Host
def decision():
    decision = input("Add new student?")
    if decision == "Y":

        read_file()
        print_students_titlecase()

        student_name = input("Enter student name: ")
        student_id = input("Enter student ID: ")
        
        add_student(student_name, student_id)
        save_file(student_name)

        print_students_titlecase()

decision()