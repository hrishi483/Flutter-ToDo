import 'package:flutter/material.dart';
import 'package:untitled/DataBase/local/DB_helper.dart';
import 'package:untitled/constants/colors.dart';
import 'package:untitled/model/todo.dart';

class TodoItem extends StatefulWidget{
  final ToDo todo;
  final Function(ToDo) onDelete;
  const TodoItem({super.key, required this.todo, required this.onDelete}) ;


  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  // late List<ToDo>toDoList;
  TimeOfDay timePicked = TimeOfDay.now();
  DBHelper dbRef = DBHelper.getInstance;
  @override
  void initState() {
    super.initState();
  }
  List<ToDo> todos = toDoList();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: const BoxDecoration(shape: BoxShape.rectangle,
            borderRadius:BorderRadius.all(Radius.circular(20)),
            color: Colors.white
          ),
        child: ListTile(
          leading: widget.todo.isDone ? IconButton(onPressed:(){_handleState(widget.todo);}, icon:const Icon(Icons.check_box, size: 30, color: Colors.blue,))
                              : IconButton(onPressed: (){_handleState(widget.todo);}, icon:const Icon(Icons.check_box_outline_blank, size:30, color: Colors.blue,)),
          title: Text(widget.todo.todoText.toString(), style: TextStyle(fontWeight: FontWeight.w400, color: tdBlack, decoration: widget.todo.isDone ? TextDecoration.lineThrough : null ),),
          subtitle: Text('Time: ${widget.todo.startTime.hour}:${widget.todo.startTime.minute}'),
          trailing: SizedBox(width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: ()async {
                          var clockTimePicked = await showTimePicker(
                            context: context,
                            initialTime: widget.todo.startTime,
                          );
                          setState(() {
                            if(clockTimePicked != null){
                              widget.todo.startTime = clockTimePicked;

                              //Update ToDo
                              dbRef.updateToDo(todo: widget.todo, clockTimePicked: clockTimePicked);
                            }
                          });
                        }, icon: const Icon(Icons.timer, color: Colors.green, size:30)),
                        IconButton(
                        icon:const Icon(Icons.delete_forever,color: Colors.red,size: 30,),
                        onPressed: () {
                        widget.onDelete(widget.todo);
                      },),
                    ]),
          )),
        );
  }


  void _handleState(todo){
    print("State Changed From ${todo.isDone}");
    setState((){
      todo.isDone = !todo.isDone;
      dbRef.updateToDo_Status(todo: todo);
    });
    print("State Changed To:!! ${todo.isDone}");
  }
}
