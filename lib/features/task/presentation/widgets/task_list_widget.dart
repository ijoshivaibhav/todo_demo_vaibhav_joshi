import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';


class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          return TaskListView(tasks: state.tasks);
        } else if (state is TaskError) {
          return Center(child: Text('Failed to load tasks: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks'));
        }
      },
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              if (value != null && value) {
                context.read<TaskBloc>().add(MarkTaskAsCompleted(task.id));
              }
            },
          ),
          onLongPress: () {
            context.read<TaskBloc>().add(DeleteTask(task.id));
          },
        );
      },
    );
  }
}
