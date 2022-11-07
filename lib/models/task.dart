import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task(this.id, this.name, this.createdAt, this.isCompleted);

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

  factory Task.create(String name, DateTime createdAt) {
    return Task(Uuid().v1(), name, createdAt, false);
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, createdAt: $createdAt, isCompleted: $isCompleted}';
  }
}
