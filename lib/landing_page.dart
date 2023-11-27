import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_test/ui/pages/home/bloc/home_bloc.dart';
import 'package:to_do_test/ui/pages/home/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeBloc = createHomeBloc();
    return MaterialApp(
      home: BlocProvider.value(
        value: homeBloc,
        child: HomePage(
          homeBloc: homeBloc,
        ),
      ),
    );
  }
}
