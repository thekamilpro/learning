student = {
    "name": "Mark",
    "student_id": 15163,
    "feedback": None
}

student["name"] == "Mark"
student["last_name"] == KeyError #Python throws error
student.get("last_name" , "Unknown") == "Unknown" #provide default value if last name cannot be found
student.keys() = ["name", "student_id", "feedback"] #returns keys from dictionary
student.values() = ["Mark", 15163, None] #list all values from the dictionary
del student["name"] #deletes key value from dictionary

#Group of dictionaries
all_students = [
    {"name": "Mark", "student_id": 15163 },
    {"name": "Katarina", "student_id": 63112 },
    {"name": "Jessica", "student_id": 30021}
]