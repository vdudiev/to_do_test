import 'package:to_do_test/app_database/app_database.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';
import 'package:to_do_test/domain/mixin/edit_task_mixin.dart';

/// Бизнес-модель начального экрана
class HomeModel with EditTaskMixin {
  @override
  final AppDatabase appDatabase;
  HomeModel({required this.appDatabase});

  Future<List<TaskEntity>> getTasks() async {
    return await appDatabase.getTasks();
  }

  Future<List<TaskEntity>> addNewTask() async {
    return await appDatabase.addTask();
  }
}
