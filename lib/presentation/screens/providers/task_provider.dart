import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/repositories/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

final taskProvider =
    StateNotifierProvider<TaskNotifier, List<TaskModel>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  final TaskRepository _repository;

  void _loadTasks() {
    state = _repository.getTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await _repository.addTask(task);
    state = [...state, task];
  }

  Future<void> toggleTask(TaskModel task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await _repository.updateTask(updatedTask);
    state = [
      for (final t in state)
        if (t.id == task.id) updatedTask else t,
    ];
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
    state = state.where((t) => t.id != id).toList();
  }
}
