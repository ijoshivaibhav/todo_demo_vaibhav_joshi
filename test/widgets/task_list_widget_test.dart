import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/entities/task.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_state.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/widgets/task_list_widget.dart';


class MockTaskBloc extends Mock implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
  });

  testWidgets('displays loading indicator while tasks are loading', (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(TaskLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskBloc>(
          create: (context) => mockTaskBloc,
          child: const TaskListWidget(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays tasks when TaskLoaded state is emitted', (WidgetTester tester) async {
    final tasks = [Task(id: '1', title: 'Test Task')];
    when(mockTaskBloc.state).thenReturn(TaskLoaded(tasks : tasks));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskBloc>(
          create: (context) => mockTaskBloc,
          child: const TaskListWidget(),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('displays error message when TaskError state is emitted', (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(const TaskError(message: 'An error occurred'));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskBloc>(
          create: (context) => mockTaskBloc,
          child: const TaskListWidget(),
        ),
      ),
    );

    expect(find.text('Error: An error occurred'), findsOneWidget);
  });
}
