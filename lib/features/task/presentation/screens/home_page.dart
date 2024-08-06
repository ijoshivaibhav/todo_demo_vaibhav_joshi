import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/util/constants/string_constants.dart';
import '../../domain/entities/task.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../widgets/task_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (filter) {
              if (filter == StringConstants.all) {
                context.read<TaskBloc>().add(LoadTasks());
              } else if (filter == StringConstants.completed) {
                context.read<TaskBloc>().add(LoadCompletedTasks());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                    value: StringConstants.all,
                    child: Text(StringConstants.allTasks)),
                const PopupMenuItem(
                    value: StringConstants.completed,
                    child: Text(StringConstants.completedTasks)),
              ];
            },
          ),
        ],
      ),
      body: const TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String taskTitle = '';
              return AlertDialog(
                title: const Text('Add New Task'),
                content: TextField(
                  onChanged: (value) {
                    taskTitle = value;
                  },
                  decoration: const InputDecoration(hintText: 'Task Title'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (taskTitle.isNotEmpty) {
                        final newTask =
                            Task(id: UniqueKey().toString(), title: taskTitle);
                        context
                            .read<TaskBloc>()
                            .add(AddTask(newTask)); // Correct event name
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
