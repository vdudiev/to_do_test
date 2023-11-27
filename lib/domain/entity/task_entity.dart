import 'package:hive_flutter/hive_flutter.dart';

part 'task_entity.g.dart';

/// Описание сущности задач
@HiveType(typeId: 0)
class TaskEntity {
  /// Название задачи
  @HiveField(0)
  final String title;

  /// Описание задачи
  @HiveField(1)
  final String subtitle;

  /// состояние активности / неактивности задачи
  @HiveField(2)
  final bool isActive;

  TaskEntity({required this.title, this.isActive = true, required this.subtitle});
}
