
// Define Task Event
import '../../domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);
}

class MarkTaskAsCompleted extends TaskEvent {
  final String id;

  MarkTaskAsCompleted(this.id);
}

class FilterTaskList extends TaskEvent {
  final String filter;

  FilterTaskList(this.filter);
}

class LoadCompletedTasks extends TaskEvent {}

class LoadPendingTasks extends TaskEvent {}