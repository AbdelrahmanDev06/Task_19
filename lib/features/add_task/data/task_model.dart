import 'package:hive_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String subtitle;

  @HiveField(2)
  String status;

  @HiveField(3)
  int colorValue;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.colorValue,
  });
}
