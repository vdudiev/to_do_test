import 'package:to_do_test/domain/entity/task_entity.dart';

/// Родительский класс состояний страницы задачи
abstract class TaskState {
  /// задача
  final TaskEntity task;
  TaskState(this.task);
}

class TaskInitState extends TaskState {
  TaskInitState(super.task);
}

class TaskErrorState extends TaskState {
  TaskErrorState(super.task);
}

class TaskEditOrRemoveSuccessState extends TaskState {
  TaskEditOrRemoveSuccessState(super.task);
}
