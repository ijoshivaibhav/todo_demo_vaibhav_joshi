import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/di/injection.dart' as di;
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/blocs/task_bloc.dart';
import 'package:todo_demo_vaibhav_joshi/features/task/presentation/screens/home_page.dart';
import 'package:todo_demo_vaibhav_joshi/theme/theme.dart';

import 'di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<TaskBloc>(create: (_) => sl<TaskBloc>())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: TodosTheme.light,
        darkTheme: TodosTheme.dark,
        home: HomePage(),
      ),
    );
  }
}
