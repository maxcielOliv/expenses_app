import 'package:despesas_app/app/views/home_Page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(useMaterial3: true),
      routes: {'/': (context) => const HomePage()},
    );
  }
}
