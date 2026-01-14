import 'package:hive/hive.dart';

class ToDoStorage {
  final String boxName = "tasksBox";

  Future<List<dynamic>> loadTasks(String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key, defaultValue: []) as List<dynamic>;
  }

  Future<void> saveTasks(String key, List tasks) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, tasks);
  }
}
