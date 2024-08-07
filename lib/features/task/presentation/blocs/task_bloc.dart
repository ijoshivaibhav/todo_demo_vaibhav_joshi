import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/filter_tasks_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_pending_task_usecase.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_completed_task_usecase.dart';
import '../../domain/usecases/get_task_use_case.dart';
import '../../domain/usecases/mark_task_completed_use_case.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final GetCompletedTasksUseCase getCompleteTaskUseCase;
  final MarkTaskCompletedUseCase markTaskCompletedUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final FilterTasksUseCase filterTasksUseCase;
  final GetPendingTasksUseCase pendingTasksUseCase;

  TaskBloc(
    this.getTasksUseCase,
    this.addTaskUseCase,
    this.deleteTaskUseCase,
    this.markTaskCompletedUseCase,
    this.filterTasksUseCase,
    this.getCompleteTaskUseCase,
    this.pendingTasksUseCase,
  ) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddNewTask);
    on<DeleteTask>(_onDeleteExistingTask);
    on<MarkTaskAsCompleted>(_onMarkTaskAsCompleted);
    on<FilterTaskList>(_onFilterTaskList);
    on<LoadCompletedTasks>(_onLoadCompletedTasks);
    on<LoadPendingTasks>(_onLoadPendingTasks);
    //Grocery shopping At DMART
    //Meeting with General Manager at 7 PM
    //Create a presentation on clean architecture
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getTasksUseCase.call();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onAddNewTask(AddTask event, Emitter<TaskState> emit) async {
    await addTaskUseCase.call(event.task);
    add(LoadTasks());
  }

  Future<void> _onDeleteExistingTask(
      DeleteTask event, Emitter<TaskState> emit) async {
    await deleteTaskUseCase.call(event.taskId);
    add(LoadTasks());
  }

  Future<void> _onMarkTaskAsCompleted(
      MarkTaskAsCompleted event, Emitter<TaskState> emit) async {
    await markTaskCompletedUseCase.call(event.id);
    add(LoadTasks());
  }

  void _onFilterTaskList(FilterTaskList event, Emitter<TaskState> emit) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks =
          filterTasksUseCase.call(currentState.tasks, event.filter);
      emit(TaskLoaded(tasks: filteredTasks));
    }
  }

  Future<void> _onLoadCompletedTasks(
      LoadCompletedTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getCompleteTaskUseCase.call();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
  Future<void> _onLoadPendingTasks(
      LoadPendingTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await pendingTasksUseCase.call();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
}
