/// Родительский класс событий начальной страницы
abstract class HomeEvent {}

/// Загрузка всех событий
class HomeLoadEvent extends HomeEvent {}

/// Добавить новую задачу
class HomeAddNewTaskEvent extends HomeEvent {}

/// Изменить статус активности задачи
class HomeChangeTaskActiveEvent extends HomeEvent {
  final int index;
  final bool isActive;
  final String title;
  final String subtitle;

  HomeChangeTaskActiveEvent({
    required this.index,
    required this.isActive,
    required this.title,
    required this.subtitle,
  });
}
