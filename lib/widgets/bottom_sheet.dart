import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:hexcolor/hexcolor.dart';

buildBottomSheet(context) {
  var value;
  showModalBottomSheet(
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
              print('value: $value');
            },
          ),
        ],
      ),
    ),
  );
}

onSumbited(value, context) {
  print(value);
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

  DatePicker.showDateTimePicker(
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
      var taskToBeAdded = Task.create(value, time);
    },
  );
}
