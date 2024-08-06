
import '../entities/task.dart';

class FilterTasksUseCase {
  List<Task> call(List<Task> tasks, String filter) {
    switch (filter) {
      case 'completed':
        return tasks.where((task) => task.isCompleted).toList();
      case 'pending':
        return tasks.where((task) => !task.isCompleted).toList();
      default:
        return tasks;
    }
  }
}
