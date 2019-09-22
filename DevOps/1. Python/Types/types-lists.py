#empty list
student_names = []

#list
student_names = ["Mark", "Katarina", "Jessica"]

#accessing lists
student_names[0] == "Mark"
student_names[2] == "Jessica"

#Last entry
student_names[-1] == "Jessica"

#Adding to list
student_names = ["Mark", "Katarina", "Jessica"]
student_names.append("Hommer") #Add to end
student_names = ["Mark", "Katarina", "Jessica","Homer"]
"Mark" in student_names == True #Check if mark is there

#How many elements in the list
len(student_names) == 4

#Delete record from the list
del student_names[2] #Jessica is no longer in the list

##LIST SLICING##

student_names = student_names = ["Mark", "Katarina","Homer"]
student_names[1:] == ["Katarina", "Homer"]
student_names[1: -1] == ["Katarina"]