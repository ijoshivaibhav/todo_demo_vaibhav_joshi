import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/entities/task.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_event.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_state.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/screens/home_page.dart';

class MockTaskBloc extends Mock implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
  });

  testWidgets('shows Add Task dialog and adds a task',
      (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(TaskInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskBloc>(
          create: (context) => mockTaskBloc,
          child: const HomePage(),
        ),
      ),
    );

    // Open the dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify dialog is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Enter task title and add task
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that AddNewTask event is added
    final task = Task(id: '1', title: 'New Task');

    // Act
    mockTaskBloc.add(AddTask(task));

    // Verify the add method was called with the specific AddTask event
    verify(mockTaskBloc.add(AddTask(task))).called(1);
      });

  testWidgets('displays tasks correctly', (WidgetTester tester) async {
    final tasks = [Task(id: '1', title: 'Test Task')];
    when(mockTaskBloc.state).thenReturn(TaskLoaded(tasks: tasks));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskBloc>(
          create: (context) => mockTaskBloc,
          child: const HomePage(),
        ),
      ),
    );

    // Check if the task title is displayed
    expect(find.text('Test Task'), findsOneWidget);
  });
}
