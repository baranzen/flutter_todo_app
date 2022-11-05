import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    print(widget.task.createdAt);
    textEditingController.text = widget.task.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
          leading: tickIcon(),
          title: widget.task.isCompleted
              ? Text(
                  widget.task.name,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                )
              : TextField(
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: null,
                  controller: textEditingController,
                  onChanged: (value) {
                    widget.task.name = value;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                ),
          trailing: Text(
            /*           widget.task.createdAt.day == DateTime.now().day
                ? 'Today'
                : widget.task.createdAt.day == DateTime.now().day + 1
                    ? 'Tomorrow'
                    :  */
            DateFormat('hh:mm').format(widget.task.createdAt),
          ),
        ),
      ),
    );
  }

  GestureDetector tickIcon() {
    return GestureDetector(
      child: CircleAvatar(
        radius: 18,
        backgroundColor: widget.task.isCompleted ? Colors.green : null,
        child: widget.task.isCompleted
            ? Icon(Icons.check, color: Colors.white)
            : null,
      ),
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
    );
  }
}
