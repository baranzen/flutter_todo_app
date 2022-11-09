import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/widgets/snackbar.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(
      {required this.taskList, required this.deleteTaskFromHomePage});
  final List<Task> taskList;
  Function deleteTaskFromHomePage;

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filtiredList = taskList
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (query.isEmpty) {
      return Container(
        color: HexColor('#BAD1C2'),
      );
    } else {
      return SearchBody(
        taskList: filtiredList,
        query: query,
        deleteTaskFromHomePage: (toBeDeletedTask) {
          deleteTaskFromHomePage(toBeDeletedTask);
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: HexColor('#BAD1C2'),
    );
  }
}

// ignore: must_be_immutable
class SearchBody extends StatefulWidget {
  SearchBody({
    super.key,
    required this.taskList,
    required this.deleteTaskFromHomePage,
    required this.query,
  });
  Function deleteTaskFromHomePage;
  List<Task> taskList;
  String query;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = localtor<LocalStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#BAD1C2'),
      body: widget.taskList.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.taskList.length,
              itemBuilder: (context, index) {
                Task task = widget.taskList[index];
                return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete),
                      Text('task deleted'),
                      /*  Spacer(),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ), */
                    ],
                  ),
                  key: Key(task.id),
                  onDismissed: (direction) {
                    print('task has been dismissed: ${task.id}');
                    setState(() {
                      widget.taskList.removeAt(index);
                    });
                    _localStorage.deleteTask(task: task);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    buildSnackBar(context, 'task was deleted');
                    widget.deleteTaskFromHomePage(task);
                  },
                  direction: DismissDirection.startToEnd,
                  child: TaskItem(task: task),
                );
              },
            )
          : Center(
              child: Text('there is no tasks with this name: ${widget.query}'),
            ),
    );
  }
}
