import 'package:flutter/material.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_bloc.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_event.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_state.dart';

/// Виджет списка задач
class TasksList extends StatelessWidget {
  /// Тип активности данного списка (Активные /  завершенные).
  final bool isActiveList;
  final HomeState state;
  final HomeBloc homeBloc;
  const TasksList({super.key, required this.state, required this.homeBloc, required this.isActiveList});

  @override
  Widget build(BuildContext context) {
    if (state is HomeEmptyState) {
      return const Center(
        child: Text('Нет задач'),
      );
    }

    if (state is HomeLoadingState && state.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is HomeErrorState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ошибка  :('),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => homeBloc.add(HomeLoadEvent()),
            child: const Icon(Icons.restart_alt_rounded),
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: state.tasks.length,
      itemBuilder: (context, index) {
        var item = state.tasks[index];

        /// если состояние задачи совпадает с типом активности, то показываем [_TaskItem]
        ///
        /// иначе показывает [SizedBox] т.к надо сохранить начальный индекс здачи
        if (isActiveList == item.isActive) {
          return InkWell(
            onTap: () => homeBloc.onOpenTaskPage(context: context, taskEntity: item, taskIndex: index),
            child: _TaskItem(
                item,
                () => homeBloc.add(HomeChangeTaskActiveEvent(
                      subtitle: item.subtitle,
                      index: index,
                      isActive: item.isActive,
                      title: item.title,
                    ))),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _TaskItem extends StatelessWidget {
  final TaskEntity taskEntity;
  final Function onChange;
  const _TaskItem(this.taskEntity, this.onChange);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: !taskEntity.isActive, onChanged: (_) => onChange()),
      title: Text(taskEntity.title),
    );
  }
}
