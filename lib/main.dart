import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/DataBase/local/DB_helper.dart';
import 'package:untitled/constants/colors.dart';
import 'package:untitled/Widgets/ToDo_list.dart';

import 'package:untitled/model/todo.dart';

// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _SearchController = TextEditingController();
  var AddNewItemController = TextEditingController();
  DBHelper? dbRef;

  List<ToDo> todos = [];
  List<ToDo> filtered_todo = [];

  @override
  void initState() {
    // filtered_todo = todos;
    _SearchController.addListener((){
    _filterTask(_SearchController.text.toString());
    });
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    List<ToDo> fetchedTodos = await dbRef!.getAllToDos();
    todos = fetchedTodos;
    setState(() {
      filtered_todo = fetchedTodos;
    });
    print("Fetching New Elements ${fetchedTodos.length}");
  }
  
  void _deleteTodo(ToDo todo) {
    print("Deleting $todo Length of List ${todos.length}");

    setState(() {
      dbRef!.deleteToDo(todo: todo);
      getNotes();
    });
    print("Deleted Element Length of List ${todos.length}");
  }

  void _addToDo(ToDo todo) async{
    print("Adding $todo Length of List ${todos.length}");
    await dbRef!.addToDO(todo: todo);
    getNotes();
    print("Element Added to List Length = ${todos.length}");
  }

  void _filterTask(String search){
    List<ToDo> temp;
    if (search.isEmpty){
      temp = todos;
    }
    else{
       temp = todos.where((x) => x.todoText!.toLowerCase().contains(search.toLowerCase())).toList();
    }
    setState(() {
      filtered_todo = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(context),
      drawer: Drawer(
          child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: tdBGColor,
              ),
              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),  // Ensures the button is circular
                      padding: EdgeInsets.all(0),  // Removes padding to make it fit perfectly
                      backgroundColor: Colors.blue,
                      elevation: 15// Set the background color of the button
                    ),
                    onPressed: () {
                      // Your onPressed code here
                    },
                    child: CircleAvatar(
                      minRadius: 40, // Adjusts the size of the circle
                      maxRadius: 40,
                      backgroundColor: Colors.white, // Circle color
                      child: Icon(Icons.person_rounded, size: 40), // Icon inside the circle
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("Hrishikesh Ravindra Karande", style: TextStyle(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis, maxLines: 3,)),
                  ]

              ),
              
            ),
          ],
            ),
      ),
      body: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Positioned(
                top:10,
                left: 0,
                right: 0,
                child: searchBox(_SearchController)
              ),
              Positioned(
                top: 90,
                left: 10,
                right: 0,
                child:  Container(
                // margin: EdgeInsets.only(top: 60, left: 15),
                child: const Text(
                  "All Tasks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  textAlign: TextAlign.left,
                ),
              ),),
              Positioned(
                top: 150, // Distance below the Text
                left: 0,
                right: 0,
                bottom: 70,
                child: filtered_todo.isNotEmpty ? ListView.builder(
                  itemCount: filtered_todo.length,
                  itemBuilder: (context,index){
                    return TodoItem(todo: filtered_todo[index], onDelete: _deleteTodo);
                  }
                ):const Center(
                  child: Text(
                    "No To-Dos left!",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),


            Align(
              alignment: Alignment.bottomCenter,
              child: AddNewTask(todos,AddNewItemController,_addToDo)),
          ]
      ),


    );
  }
}

 AppBar buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: tdBGColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (innerContext) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black, size: 30),
              onPressed: () {
                Scaffold.of(innerContext).openDrawer();
              },
            ),
          ),
          Container( height: 60,width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)) ,
            padding: const EdgeInsets.symmetric(horizontal: 5), child:Image.asset("assets/images/Hrishi.jpg"),
          )
        ],
      ),
    );
}

Widget searchBox(TextEditingController SearchController){
  return Padding(padding: const EdgeInsets.symmetric(horizontal:25, vertical: 15),
      child: Container(decoration: BoxDecoration(border: Border.all(color: tdBGColor),
             borderRadius: const BorderRadius.all(Radius.circular(21)), color: Colors.white),
          child:Container(padding:const EdgeInsets.symmetric(horizontal: 5),
          child:TextField(controller: SearchController ,decoration: const InputDecoration(contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.black, size: 20, ),
          prefixIconConstraints: BoxConstraints(maxHeight: 25, maxWidth: 25),
          hintText: "Search... ",
          border: InputBorder.none
        ),
      )
    ))
  );
}

Widget AddNewTask(List<ToDo> todos, TextEditingController AddNewItemController, Function(ToDo) AddToDo) {
  TimeOfDay timePicked = TimeOfDay.now();
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey)],
            borderRadius: BorderRadius.circular(21),
          ),
          height: 50, // Give it some height
          child: TextField(controller: AddNewItemController,decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),
              prefixIconConstraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
              hintText: "Add new Task... ",
              border: InputBorder.none,
              suffixIcon:Builder(
                  builder: (BuildContext context){
                  return SizedBox(child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: ()async{
                          timePicked = await showTimePicker(context: context, initialTime: TimeOfDay.now()) ?? TimeOfDay.now();
                        }, icon: const Icon(Icons.timer, color: Colors.green,)),
                        IconButton(onPressed: (){
                        int newId = todos.length;
                        String todoTitle = AddNewItemController.text.toString();
                        if (todoTitle.length >1) {
                          ToDo todo = ToDo(id: newId.toString(), startTime:timePicked, todoText:todoTitle, isDone: false);
                          AddToDo(todo);
                          AddNewItemController.clear();
                        }
                        else{
                          final snackBarWidget = SnackBar(
                            content: const Text("Task title cannot be empty!"),
                            action: SnackBarAction(
                              label: "OK",
                              onPressed: () {
                              print("Snackbar OK Pressed");
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBarWidget);
                        }
                      },
                          icon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              color: Colors.blue,
                              child: const Icon(Icons.add, size: 30, color: Colors.white,)
                          ),
                    )
                  ]));
                }
              ),
        ),
      ),
    ))
    ],
  );
}