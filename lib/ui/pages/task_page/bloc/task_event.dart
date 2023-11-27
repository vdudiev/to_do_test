import 'package:flutter/material.dart';

/// Родительский класс событий страницы задачи
abstract class TaskEvent {}

class TaskOpenEditPageEvent extends TaskEvent {
  final BuildContext context;
  TaskOpenEditPageEvent({required this.context});
}

class TaskRemoveEvent extends TaskEvent {}

class TaskChangeStateEvent extends TaskEvent {}
