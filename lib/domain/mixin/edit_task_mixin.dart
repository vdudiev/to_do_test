import 'package:to_do_test/app_database/app_database.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';

/// бизнес-логика редактирования задачи
mixin EditTaskMixin {
  /// Класс-обёртка для работы с базой данных.
  abstract final AppDatabase appDatabase;

  Future<TaskEntity?> editTask({
    required int index,
    required String title,
    required String subtitle,
    required bool isActive,
  }) async {
    return await appDatabase.editTask(index: index, title: title, subtitle: subtitle, isActive: isActive);
  }
}
