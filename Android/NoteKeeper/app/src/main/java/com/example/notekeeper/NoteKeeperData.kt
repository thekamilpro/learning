package com.example.notekeeper

class CourseInfo (val courseId: String, val title: String)

class NoteInfo (var course: CourseInfo, var title: String, var text: String)