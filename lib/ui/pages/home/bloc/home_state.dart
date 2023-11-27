import 'package:to_do_test/domain/entity/task_entity.dart';

/// Родительский класс состояний начальной страницы
abstract class HomeState {
  /// Cписок задач
  final List<TaskEntity> tasks;
  HomeState(this.tasks);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState(super.tasks);
}

class HomeErrorState extends HomeState {
  HomeErrorState(super.tasks);
}

class HomeEmptyState extends HomeState {
  HomeEmptyState() : super(<TaskEntity>[]);
}

class HomeLoadedState extends HomeState {
  HomeLoadedState(super.tasks);
}
