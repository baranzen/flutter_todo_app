import 'package:uuid/uuid.dart';

class Task {
  Task(this.id, this.name, this.createdAt, this.isCompleted);

  final String id;
  final String name;
  final DateTime createdAt;
  final bool isCompleted;

  factory Task.create(String name, DateTime createdAt) {
    return Task(Uuid().v1(), name, createdAt, false);
  }
}
