import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import '../components/todo.dart';
import '../components/add.dart';

class Academic extends StatefulWidget {
  const Academic({super.key});

  @override
  State<Academic> createState() => _AcademicState();
}

class _AcademicState extends State<Academic> {
  List tasks = [];
  late Box tasksBox;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box('tasksBox');
    loadTasks();
  }

  void loadTasks() async {
    final storedTasks = tasksBox.get('schoolTasks', defaultValue: []);
    tasks = List<Map>.from(storedTasks);
    setState(() {});
  }

  void saveTasks() {
    tasksBox.put('schoolTasks', tasks);
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        controller: controller,
        onSave: () {
          setState(() {
            tasks.add({"task": controller.text, "completed": false});
          });
          controller.clear();
          saveTasks();
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void toggleCheckbox(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => ToDoComponent(
          taskName: tasks[index]["task"],
          taskCompleted: tasks[index]["completed"],
          onChanged: (value) => toggleCheckbox(index),
          deleteTask: () => deleteTask(index),
        ),
      ),
    );
  }
}
