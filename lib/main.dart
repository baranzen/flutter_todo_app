import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helper/theme.dart';

import 'pages/home_page.dart';

void main() {
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
