import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/app_database/app_database.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_event.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_state.dart';
import 'package:to_do_test/ui/pages/home/home_model.dart';
import 'package:to_do_test/ui/pages/task_page/task_page.dart';

/// Di для [HomeBloc]
HomeBloc createHomeBloc() {
  /// ps Из-за спешки не стал уже делать контейнер для [AppDataBase].
  var homeModel = HomeModel(appDatabase: AppDatabase());
  return HomeBloc(homeModel);
}

/// [Bloc] начальной страницы
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeModel _homeModel;
  var _tasks = <TaskEntity>[];
  HomeBloc(this._homeModel) : super(HomeEmptyState()) {
    on<HomeLoadEvent>(_loadTasks);
    on<HomeAddNewTaskEvent>(_addNewTask);
    on<HomeChangeTaskActiveEvent>(_changeActiveStatus);
  }

  FutureOr<void> _loadTasks(HomeLoadEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState(_tasks));
      _tasks = await _homeModel.getTasks();
      if (_tasks.isEmpty) {
        emit(HomeEmptyState());
      } else {
        emit(HomeLoadedState(_tasks));
      }
    } catch (e) {
      emit(HomeErrorState(_tasks));
    }
  }

  FutureOr<void> _addNewTask(HomeAddNewTaskEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState(_tasks));

      _tasks = await _homeModel.addNewTask();
      if (_tasks.isEmpty) {
        emit(HomeEmptyState());
      } else {
        emit(HomeLoadedState(_tasks));
      }
    } catch (e) {
      emit(HomeErrorState(_tasks));
    }
  }

  FutureOr<void> _changeActiveStatus(HomeChangeTaskActiveEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState(_tasks));
      var task = await _homeModel.editTask(
          index: event.index, title: event.title, subtitle: event.subtitle, isActive: !event.isActive);
      if (task != null) {
        _tasks = await _homeModel.getTasks();
        if (_tasks.isEmpty) {
          emit(HomeEmptyState());
        } else {
          emit(HomeLoadedState(_tasks));
        }
      } else {
        emit(HomeErrorState(_tasks));
      }
    } catch (e) {
      emit(HomeErrorState(_tasks));
    }
  }

  void onOpenTaskPage(
      {required BuildContext context, required TaskEntity taskEntity, required int taskIndex}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskPage(
                  taskEntity: taskEntity,
                  taskIndex: taskIndex,
                  homeBloc: this,
                )));
  }
}
