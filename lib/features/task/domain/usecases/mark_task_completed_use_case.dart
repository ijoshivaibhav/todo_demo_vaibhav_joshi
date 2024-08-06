
import '../repositories/task_repository.dart';

class MarkTaskCompletedUseCase {
  final TaskRepository repository;

  MarkTaskCompletedUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.markTaskCompleted(id);
  }
}


