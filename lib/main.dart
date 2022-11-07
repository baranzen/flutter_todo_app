import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/helper/theme.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

final localtor = GetIt.instance;

void initGetIt() {
  localtor.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> initHive() async {
  await Hive.initFlutter('hive');
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      home: HomePage(),
    );
  }
}
