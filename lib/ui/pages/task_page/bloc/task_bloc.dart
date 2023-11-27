// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/app_database/app_database.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';
import 'package:to_do_test/ui/pages/task_edit_page.dart/task_edit_page.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_event.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_state.dart';
import 'package:to_do_test/ui/pages/task_page/task_model.dart';

/// DI для [TaskBloc]
TaskBloc createTaskBloc({
  required TaskEntity taskEntity,
  required int taskIndex,
  required BuildContext context,
}) {
  /// ps Из-за спешки не стал уже делать контейнер для [AppDataBase].
  var taskModel = TaskModel(appDatabase: AppDatabase());
  return TaskBloc(
    context: context,
    taskEntity: taskEntity,
    taskIndex: taskIndex,
    taskModel: taskModel,
  );
}

/// [Bloc] страницы задачи
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late TaskEntity _taskEntity;
  late final int _taskIndex;
  late final TaskModel _taskModel;
  late final BuildContext _context;

  final titleTextController = TextEditingController();
  final subtitleTextController = TextEditingController();

  TaskBloc({
    required TaskEntity taskEntity,
    required int taskIndex,
    required TaskModel taskModel,
    required BuildContext context,
  }) : super(TaskInitState(taskEntity)) {
    _taskEntity = taskEntity;
    _taskIndex = taskIndex;
    _taskModel = taskModel;
    _context = context;

    /// Обработчик события редактирования задачи.
    on<TaskOpenEditPageEvent>(_startEditEvent);

    /// Обработчик события удаления задачи
    on<TaskRemoveEvent>(_removeTask);

    /// Обработчик события изменения статуса задачи
    on<TaskChangeStateEvent>(_changeTaskState);
  }

  FutureOr<void> _startEditEvent(TaskOpenEditPageEvent event, Emitter<TaskState> emit) async {
    titleTextController.text = _taskEntity.title;
    subtitleTextController.text = _taskEntity.subtitle;
    try {
      bool doEdit = await Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => TaskEditPAge(taskBloc: this),
          ));

      if (doEdit) {
        var editedTask = await _taskModel.editTask(
            index: _taskIndex,
            title: titleTextController.text,
            subtitle: subtitleTextController.text,
            isActive: _taskEntity.isActive);
        if (editedTask != null) {
          _taskEntity = editedTask;
          emit(TaskEditOrRemoveSuccessState(_taskEntity));
        } else {
          emit(TaskErrorState(_taskEntity));
        }
      }
    } catch (e) {
      emit(TaskErrorState(_taskEntity));
    }
  }

  FutureOr<void> _removeTask(TaskRemoveEvent event, Emitter<TaskState> emit) async {
    try {
      await _taskModel.removeTask(index: _taskIndex);
      emit(TaskEditOrRemoveSuccessState(_taskEntity));
      _closeTaskPage();
    } catch (e) {
      emit(TaskErrorState(_taskEntity));
    }
  }

  FutureOr<void> _changeTaskState(TaskChangeStateEvent event, Emitter<TaskState> emit) async {
    try {
      var task = await _taskModel.editTask(
          index: _taskIndex,
          title: _taskEntity.title,
          subtitle: _taskEntity.subtitle,
          isActive: !_taskEntity.isActive);
      if (task != null) {
        _taskEntity = task;
        emit(TaskEditOrRemoveSuccessState(_taskEntity));
      } else {
        emit(TaskErrorState(_taskEntity));
      }
    } catch (e) {
      emit(TaskErrorState(_taskEntity));
    }
  }

  void _closeTaskPage() {
    Navigator.pop(_context);
  }

  void closeEditPage({required BuildContext context, required bool doEdit}) {
    Navigator.pop(context, doEdit);
  }
}
