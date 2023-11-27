import 'package:to_do_test/app_database/app_database.dart';
import 'package:to_do_test/domain/mixin/edit_task_mixin.dart';

/// Бизнес-модель экрана задачи
class TaskModel with EditTaskMixin {
  @override
  final AppDatabase appDatabase;
  TaskModel({required this.appDatabase});

  Future<void> removeTask({required int index}) async {
    await appDatabase.removeTask(index: index);
  }
}
