import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';

/// Класс-обёртка для работы с базой данных.
class AppDatabase {
  late Box<TaskEntity> _hiveBox;

  /// колбэк получения задач
  Future<List<TaskEntity>> getTasks() async {
    await _openDBBox();
    var tasks = _hiveBox.values.toList();
    await _closeDBBox();
    return tasks;
  }

  /// колбэк добваления задачи
  Future<List<TaskEntity>> addTask() async {
    await _openDBBox();
    await _hiveBox.add(TaskEntity(
      title: 'Новая Задача',
      subtitle: 'Описание задачи',
    ));
    var tasks = _hiveBox.values.toList();
    await _closeDBBox();
    return tasks;
  }

  /// колбэк удаления задачи
  Future<List<TaskEntity>> removeTask({required int index}) async {
    await _openDBBox();
    _hiveBox.deleteAt(index);
    var tasks = _hiveBox.values.toList();
    await _closeDBBox();
    return tasks;
  }

  /// колбэк редактирования задачи
  Future<TaskEntity?> editTask({
    required int index,
    required String title,
    required String subtitle,
    required bool isActive,
  }) async {
    await _openDBBox();
    _hiveBox.putAt(
        index,
        TaskEntity(
          title: title,
          subtitle: subtitle,
          isActive: isActive,
        ));
    var task = _hiveBox.getAt(index);
    await _closeDBBox();
    return task;
  }

  Future<void> _openDBBox() async {
    _hiveBox = await Hive.openBox<TaskEntity>('tasks');
  }

  Future<void> _closeDBBox() async {
    await _hiveBox.close();
  }
}
