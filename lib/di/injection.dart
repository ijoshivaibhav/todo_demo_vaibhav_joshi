import 'package:get_it/get_it.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/add_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/filter_tasks_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_completed_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_pending_task_usecase.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/get_task_use_case.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/domain/usecases/mark_task_completed_use_case.dart';

import '../features/task/data/datasources/task_local_data_source.dart';
import '../features/task/data/datasources/task_local_data_source_impl.dart';
import '../features/task/data/repositories/task_repository_impl.dart';
import '../features/task/domain/repositories/task_repository.dart';
import '../features/task/presentation/blocs/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => TaskBloc(
    sl(),
    sl(),
    sl(),
    sl(),
    sl(),
    sl(),
    sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => MarkTaskCompletedUseCase(sl()));
  sl.registerLazySingleton(() => FilterTasksUseCase());
  sl.registerLazySingleton(() => GetCompletedTasksUseCase(sl())); // Ensure this is registered
  sl.registerLazySingleton(() => GetPendingTasksUseCase(sl())); // Ensure this is registered

  // Repository
  sl.registerLazySingleton<TaskRepository>(
          () => TaskRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(
          () => TaskLocalDataSourceImpl());
}