// ignore_for_file: unused_field

import 'package:flutter_todo_app/models/task.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required int id}); //! gerek yok suanlik uygulamada
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<void> updateTask({required Task task});
  Future<void> deleteAllTaskFromDisk(List<Task> taskList);
}

class HiveLocalStorage extends LocalStorage {
  late Box<Task> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box<Task>('task');
  }
  //! Add Task
  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.add(task);
  }

  //! Get All Task
  @override
  Future<Task?> getTask({required int id}) async {
    if (_taskBox.containsKey(id)) {
      return _taskBox.get(id);
    } else {
      return null; // nullable?
    }
  }

  //! Delete Task
  @override
  Future<bool> deleteTask({required Task task}) async {
    await task.delete();
    return true;
  }

  //! Get all Task
  @override
  Future<List<Task>> getAllTask() async {
    List<Task> allTask = <Task>[];
    allTask = _taskBox.values.toList();
    if (allTask.isNotEmpty) {
      allTask.sort((Task a, Task b) => b.createdAt.compareTo(a.createdAt));
    }
    return allTask;
  }

  //! Update Task
  @override
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  @override
  Future<void> deleteAllTaskFromDisk(List<Task> taskList) async {
    taskList.isNotEmpty ? await _taskBox.clear() : null;
  }
}
