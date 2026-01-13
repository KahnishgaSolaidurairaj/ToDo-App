import 'package:flutter/material.dart';

class ToDoComponent extends StatelessWidget {
  const ToDoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(19.0),
        child: Text("This is a To-Do item"),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      )
    );
  }
}