import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetPendingTasksUseCase {
  final TaskRepository repository;

  GetPendingTasksUseCase(this.repository);

  Future<List<Task>> call() async {
    final allTasks = await repository.getTasks();
    return allTasks.where((task) => task.isCompleted == false).toList();
  }
}
