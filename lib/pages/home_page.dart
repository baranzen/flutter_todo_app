import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> taskList;

  @override
  void initState() {
    super.initState();
    taskList = <Task>[];
    taskList.add(Task.create('take a walk around 🚶', DateTime.now()));
    taskList.add(Task.create('drink water 🧊', DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#BAD1C2'),
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: const Text('Today Todos'),
              onTap: () => buildBottomSheet(context),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //show bottom sheet
                buildBottomSheet(context);
              },
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: taskList.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                Task task = taskList[index];
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
                      taskList.removeAt(index);
                    });
                  },
                  direction: DismissDirection.startToEnd,
                  child: TaskItem(task: task),
                );
              },
            )
          : Center(
              child: GestureDetector(
                onTap: () => buildBottomSheet(context),
                child: Text('there is no tasks, lets add one'),
              ),
            ),
    );
  }

  Future<void> buildBottomSheet(context) async {
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
              child: const Text('Add'),
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
        onConfirm: (time) {
          print(time);
          var taskToBeAdded = Task.create(value, time);
          taskList.add(taskToBeAdded);
          setState(() {});
        },
      );
    } else {
      return;
    }
  }
}
