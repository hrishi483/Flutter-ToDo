import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/model/todo.dart';

class DBHelper{
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
  static const String TABLE_NAME = "TODO";
  static const String TITLE_COLUMN = "TITLE";
  static const String TIME_COLUMN = "TIME";
  static const String STATUS_COLUMN = "STATUS";

  Database? myDB;

  Future<Database> getDB() async{
    myDB = myDB ?? await openDB();
    return myDB!;
  }

  Future<Database> openDB() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDir.path,"ToDO.DB");

    return await openDatabase(dbPath, onCreate: (db,version ){
      db.execute('''CREATE TABLE $TABLE_NAME(
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      $TITLE_COLUMN TEXT NOT NULL,
                      $TIME_COLUMN TEXT NOT NULL,
                      $STATUS_COLUMN INTEGER NOT NULL
                    )
               ''');
    },version: 1);
  }

  Future<bool> addToDO({required ToDo todo}) async{
    var db = await getDB();
    int check = await db.insert(TABLE_NAME, {TITLE_COLUMN: todo.todoText, TIME_COLUMN:todo.startTime.toString(), STATUS_COLUMN:todo.isDone});
    return check>0;
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    print(timeString);
    if (timeString == null || timeString.trim().isEmpty) {
      print("Warning: Invalid time format, returning default TimeOfDay.now()");
      return TimeOfDay.now();
    }
    try {
      // Clean the input string: Remove 'TimeOfDay(' and trailing ')'
      String cleanedTimeString = timeString.replaceAll(RegExp(r'TimeOfDay\(|\)'), '').trim();

      print("Cleaned time string: $cleanedTimeString"); // Debugging

      // Split the cleaned string
      final parts = cleanedTimeString.split(":");
      if (parts.length != 2) throw FormatException("Invalid time format");

      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
      } catch (e) {
        print("Error parsing time: $e");
        return TimeOfDay.now(); // Fallback
      }
    }

  Future<List<ToDo>> getAllToDos() async{
    var db = await getDB();
    List<Map<String, dynamic>> data = await db.query(TABLE_NAME);
    return data.map((todo) =>ToDo(id: todo['ID'].toString(),
        startTime: _parseTimeOfDay(todo[TIME_COLUMN]),
        todoText: todo[TITLE_COLUMN].toString(),
        isDone: todo[STATUS_COLUMN] == 1)).toList();
  }

  void deleteToDo({required ToDo todo}) async{
    var db = await getDB();
    await db.execute("DELETE FROM $TABLE_NAME WHERE ID = ${todo.id}");
  }

  void updateToDo({required ToDo todo, required TimeOfDay clockTimePicked}) async{
    var db = await getDB();
    await db.execute("UPDATE $TABLE_NAME SET $TIME_COLUMN = ${clockTimePicked.toString()} WHERE ID = ${todo.id}");
  }

  void updateToDo_Status({required ToDo todo}) async{
    var db = await getDB();
    await db.execute("UPDATE $TABLE_NAME SET $STATUS_COLUMN = ${todo.isDone} WHERE ID = ${todo.id}");
    print("State Updated in DB");
  }
}

