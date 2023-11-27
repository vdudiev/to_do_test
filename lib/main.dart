import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_test/domain/entity/task_entity.dart';

import 'package:to_do_test/landing_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  runApp(const LandingPage());
}
