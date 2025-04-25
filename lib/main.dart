import 'package:despesas_app/app/views/app.dart';
import 'package:despesas_app/config/hive_config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(const App());
}
