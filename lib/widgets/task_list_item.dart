import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#DEF5E5').withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorHepler.getColor(3),
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(widget.task.name),
          leading: GestureDetector(
            child: CircleAvatar(
              child: widget.task.isCompleted
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),
            onTap: () {
              setState(() {
                widget.task.isCompleted = !widget.task.isCompleted;
              });
            },
          ),
        ),
      ),
    );
  }
}
