import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          if (value == true) {
            context.read<TaskBloc>().add(MarkTaskAsCompleted(task.id));
          }
        },
      ),
      onLongPress: () {
        context.read<TaskBloc>().add(DeleteTask(task.id));
      },
    );
  }
}
