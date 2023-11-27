import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';
import 'package:to_do_test/ui/common_widgets/main_button.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_bloc.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_event.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_bloc.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_event.dart';
import 'package:to_do_test/ui/pages/task_page/bloc/task_state.dart';

///  Экран детальной информации о задаче
class TaskPage extends StatelessWidget {
  final TaskEntity taskEntity;
  final int taskIndex;
  final HomeBloc homeBloc;

  const TaskPage({super.key, required this.taskEntity, required this.taskIndex, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    var taskBloc = createTaskBloc(
      taskEntity: taskEntity,
      taskIndex: taskIndex,
      context: context,
    );
    return BlocProvider.value(
      value: taskBloc,
      child: BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
        if (state is TaskEditOrRemoveSuccessState) {
          homeBloc.add(HomeLoadEvent());
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            actions: [
              InkWell(
                  onTap: () => taskBloc.add(TaskOpenEditPageEvent(context: context)),
                  child: const Icon(Icons.edit))
            ],
            title: Text(
              state.task.title,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
                child: Text(
                  state.task.subtitle,
                  textAlign: TextAlign.center,
                )),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: Mainbutton(
                        title: state.task.isActive ? 'Завершить' : 'Активировать',
                        ontap: () => taskBloc.add(TaskChangeStateEvent()),
                        color: Colors.blue)),
                const SizedBox(width: 20),
                Expanded(
                    child: Mainbutton(
                        title: 'Удалить', ontap: () => taskBloc.add(TaskRemoveEvent()), color: Colors.red)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
