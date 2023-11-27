import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_bloc.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_event.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_state.dart';
import 'package:to_do_test/ui/pages/home/widgets/task_list.dart';

class HomePage extends StatelessWidget {
  final HomeBloc homeBloc;
  const HomePage({
    required this.homeBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    homeBloc.add(HomeLoadEvent());
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<HomeBloc, HomeState>(
          bloc: homeBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: const Center(
                  child: Text(
                    "Список Задач",
                  ),
                ),
                bottom: const TabBar(indicatorColor: Colors.blue, indicatorWeight: 3, tabs: [
                  Tab(
                    text: "Активные",
                  ),
                  Tab(
                    text: "Завершенные",
                  )
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => homeBloc.add(HomeAddNewTaskEvent()),
                child: const Icon(Icons.add),
              ),
              body: TabBarView(children: [
                TasksList(
                  isActiveList: true,
                  state: state,
                  homeBloc: homeBloc,
                ),
                TasksList(
                  isActiveList: false,
                  state: state,
                  homeBloc: homeBloc,
                )
              ]),
            );
          }),
    );
  }
}
