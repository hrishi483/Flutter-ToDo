import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoText;
  TimeOfDay startTime;
  bool isDone;

  ToDo({required this.id, TimeOfDay?startTime,required this.todoText ,required this.isDone}):startTime = startTime ?? TimeOfDay.now();
}
List<ToDo> toDoList(){
  return [
    ToDo(id:"01", todoText: "Morning Walk", isDone: true),
    ToDo(id:"02", todoText: "Check Mail", isDone: false),
    ToDo(id:"03", todoText: "LeetCode", isDone: false),
    ToDo(id:"04", todoText: "Learn Chess", isDone: true),
    ToDo(id:"05", todoText: "Android Development", isDone: true),

  ];
}
