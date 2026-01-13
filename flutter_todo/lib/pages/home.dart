import 'package:flutter/material.dart';
import '../components/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 106, 80),
      appBar: AppBar(
        title: Text('Todo App'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ToDoComponent(),
        ],
      )
    );
  }
}