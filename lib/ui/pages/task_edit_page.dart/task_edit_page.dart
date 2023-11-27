import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/ui/common_widgets/main_button.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_bloc.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_state.dart';

/// Экран для редактирования задачи
///
/// можно редактировать только имя и описнаие
///
/// слушает [Bloc] из экрана показа задачи: [TaskBloc]
class TaskEditPAge extends StatelessWidget {
  final TaskBloc taskBloc;
  const TaskEditPAge({super.key, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: taskBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(
              'Редактирование задачи',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Имя задачи'),
              TextField(
                controller: taskBloc.titleTextController,
              ),
              const SizedBox(height: 50),
              const Text('Описание задачи'),
              TextField(
                controller: taskBloc.subtitleTextController,
              ),
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: Mainbutton(
                        title: 'Сохранить',
                        ontap: () => taskBloc.closeEditPage(context: context, doEdit: true),
                        color: Colors.blue)),
                const SizedBox(width: 20),
                Expanded(
                    child: Mainbutton(
                        title: 'Отмена',
                        ontap: () => taskBloc.closeEditPage(context: context, doEdit: false),
                        color: Colors.red)),
              ],
            ),
          ),
        );
      },
    );
  }
}
