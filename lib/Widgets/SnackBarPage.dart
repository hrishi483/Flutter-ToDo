import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget{
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
          final snackbar = SnackBar(
            content:const Text("Yay A SnackBar!"),
            action: SnackBarAction(label: "Undo", onPressed: (){print("SnackBar!!");})
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
          child: const Text('Show SnackBar')
      ),
    );

  }
}