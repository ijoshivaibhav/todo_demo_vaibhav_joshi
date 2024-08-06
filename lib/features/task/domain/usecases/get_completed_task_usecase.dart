import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetCompletedTasksUseCase {
  final TaskRepository repository;

  GetCompletedTasksUseCase(this.repository);

  Future<List<Task>> call() async {
    final allTasks = await repository.getTasks();
    return allTasks.where((task) => task.isCompleted).toList();
  }
}
