
import 'package:todo_demo_vaibhav_joshi/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getCompletedTask();
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> markTaskCompleted(String id);
}
