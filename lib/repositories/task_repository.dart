import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_flow/models/task_model.dart';

class TaskRepository {
  static const String _boxName = 'tasks_box';

  Box<TaskModel> get _box => Hive.box<TaskModel>(_boxName);

  List<TaskModel> getTasks() => _box.values.toList();

  Future<void> addTask(TaskModel task) async {
    await _box.put(task.id, task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await _box.delete(id);
  }

  List<Map<String, dynamic>> getTasksAsJson() {
    return _box.values.map((task) => task.toJson()).toList();
  }
}
