

import 'package:todo_demo_vaibhav_joshi/features/task/data/datasources/task_local_data_source.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/data/models/task_model.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final List<TaskModel> tasks = [];

  @override
  Future<List<TaskModel>> getTasks() async {
    return tasks;
  }

  @override
  Future<void> addTask(TaskModel task) async {
    tasks.add(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    tasks.removeWhere((task) => task.id == id);
  }

  @override
  Future<void> markTaskCompleted(String id) async {
    final taskIndex = tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      tasks[taskIndex] = tasks[taskIndex].copyWith(isCompleted: true);
    }
  }

  @override
  Future<List<TaskModel>> getCompletedTask() {
    final completedTasks = tasks.where((element)=> element.isCompleted).toList();
    return Future.value(completedTasks);
  }
}
