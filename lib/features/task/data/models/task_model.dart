import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';
class TaskModel extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;

  const TaskModel({required this.id, required this.title, this.isCompleted = false});

  @override
  List<Object> get props => [id, title, isCompleted];

  // Convert TaskModel to Task entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }

  // Convert Task entity to TaskModel
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
  }
  // Add a copyWith method
  TaskModel copyWith({String? id, String? title, bool? isCompleted}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
