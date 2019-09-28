students = []

class Student:
    def add_student(self, name, student_id=332): #self refers to the instance of the class
        student = {"name": name, "student_id": student_id}
        students.append(student)

student = Student()
student.add_student("Mark")

print(students)