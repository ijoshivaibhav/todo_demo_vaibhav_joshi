import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/entities/task.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/add_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/filter_tasks_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_completed_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_task_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/mark_task_completed_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_event.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_state.dart';

class MockGetTasks extends Mock implements GetTasksUseCase {}

class MockAddTask extends Mock implements AddTaskUseCase {}

class MockDeleteTask extends Mock implements DeleteTaskUseCase {}

class MockMarkTaskCompleted extends Mock implements MarkTaskCompletedUseCase {}

class MockFilterTasks extends Mock implements FilterTasksUseCase {}

class MockGetCompletedTasks extends Mock implements GetCompletedTasksUseCase {}

void main() {
  late TaskBloc taskBloc;
  late MockGetTasks mockGetTasks;
  late MockAddTask mockAddTask;
  late MockDeleteTask mockDeleteTask;
  late MockMarkTaskCompleted mockMarkTaskCompleted;
  late MockFilterTasks mockFilterTasks;
  late MockGetCompletedTasks mockGetCompletedTasks;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTask();
    mockDeleteTask = MockDeleteTask();
    mockMarkTaskCompleted = MockMarkTaskCompleted();
    mockFilterTasks = MockFilterTasks();
    mockGetCompletedTasks = MockGetCompletedTasks();
    taskBloc = TaskBloc(
      mockGetTasks,
      mockAddTask,
      mockDeleteTask,
      mockMarkTaskCompleted,
      mockFilterTasks,
      mockGetCompletedTasks,
    );
  });

  test('initial state is TaskInitial', () {
    expect(taskBloc.state, equals(TaskInitial()));
  });

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskLoaded] when LoadTasks is added and succeeds',
    build: () {
      when(mockGetTasks.call())
          .thenAnswer((_) async => [Task(id: '1', title: 'Test Task')]);
      return taskBloc;
    },
    act: (bloc) => bloc.add(LoadTasks()),
    expect: () => [
      TaskLoading(),
      TaskLoaded(tasks: [Task(id: '1', title: 'Test Task')]),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskError] when LoadTasks is added and fails',
    build: () {
      when(mockGetTasks.call()).thenThrow(Exception('Failed to load tasks'));
      return taskBloc;
    },
    act: (bloc) => bloc.add(LoadTasks()),
    expect: () => [
      TaskLoading(),
      const TaskError(
          message: 'Failed to load tasks: Exception: Failed to load tasks'),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskLoaded] when AddNewTask succeeds',
    build: () {
      final task = Task(id: '1', title: 'Test Task');
      when(mockAddTask.call(task)).thenAnswer((_) async {});
      when(mockGetTasks.call())
          .thenAnswer((_) async => [Task(id: '1', title: 'Test Task')]);
      return taskBloc;
    },
    act: (bloc) {
      bloc.add(AddTask(Task(id: '1', title: 'New Task')));
    },
    expect: () => [
      TaskLoading(),
      TaskLoaded(tasks: [Task(id: '1', title: 'Test Task')]),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskError] when AddNewTask fails',
    build: () {
      final task = Task(id: '1', title: 'Test Task');
      when(mockAddTask.call(task)).thenThrow(Exception('Failed to add task'));
      return taskBloc;
    },
    act: (bloc) {
      bloc.add(AddTask(Task(id: '1', title: 'New Task')));
    },
    expect: () => [
      TaskLoading(),
      const TaskError(
          message: 'Failed to add task: Exception: Failed to add task'),
    ],
  );

  // Similar tests can be written for DeleteTask, MarkTaskCompleted, FilterTasks, and GetCompletedTasks
}
