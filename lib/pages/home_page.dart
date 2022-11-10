import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/widgets/custom_search_delegate.dart';
import 'package:flutter_todo_app/widgets/snackbar.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _taskList;
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = localtor<LocalStorage>();
    _taskList = <Task>[];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#BAD1C2'),
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: const Text('Today\'s Todos'),
              onTap: () => buildBottomSheet(),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _showSearchPage();
                /*        final paint = Paint();
                paint.color = Colors.white;
                paint.shader = const LinearGradient(
                  colors: <Color>[Colors.red, Colors.yellow],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)); */
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //show bottom sheet
                buildBottomSheet();
              },
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: _taskList.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskList[index];
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
                      _taskList.removeAt(index);
                    });
                    _localStorage.deleteTask(task: task);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    buildSnackBar(context, 'task was deleted');
                  },
                  direction: DismissDirection.startToEnd,
                  child: TaskItem(task: task),
                );
              },
            )
          : Center(
              child: GestureDetector(
                onTap: () => buildBottomSheet(),
                child: Text('there is no tasks, lets add one'),
              ),
            ),
    );
  }

  Future<void> _showSearchPage() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(
        taskList: _taskList,
      ),
    ).then((value) => _getAllTaskFromDb());
  }

  Future<void> _getAllTaskFromDb() async {
    _localStorage.getAllTask().then((value) {
      setState(() {
        _taskList = value;
      });
    });
  }

  Future<void> buildBottomSheet() async {
    String? value;
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: HexColor('#BAD1C2').withOpacity(0.8),
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).viewInsets.bottom.toDouble()) + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter Todo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onSubmitted: (value) => onSumbited(value, context),
              onChanged: (v) => value = v,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              onPressed: () {
                onSumbited(value, context);
                print('task: $value');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSumbited(value, context) async {
    if (value != null) {
      FocusScope.of(context).unfocus();
      Navigator.pop(context);

      var textStyle = TextStyle(
        color: ColorHepler.getColor('white'),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        shadows: [
          Shadow(
            color: ColorHepler.getColor(3),
            blurRadius: 5,
          ),
        ],
      );

      await DatePicker.showDateTimePicker(
        context,
        currentTime: DateTime.now(),
        locale: LocaleType.en,
        theme: DatePickerTheme(
          doneStyle: textStyle,
          cancelStyle: textStyle,
          itemStyle: textStyle,
          backgroundColor: ColorHepler.getColor(3),
        ),
        onConfirm: (time) async {
          print(time);
          Task taskToBeAdded = Task.create(value, time);
          _taskList.insert(0, taskToBeAdded);
          await _localStorage.addTask(task: taskToBeAdded);

          setState(() {});
        },
      );
    } else {
      return;
    }
  }
}
