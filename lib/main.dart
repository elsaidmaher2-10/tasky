import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/themecontroller.dart';
import 'package:tasky/Feature/main/main_screen.dart';
import 'package:tasky/Feature/welcome/welcome_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  final name = PrefrenceManager().getstring("username");
  Themecontroller().init();
  runApp(Tasky(name: name));
}

class Tasky extends StatelessWidget {
  const Tasky({super.key, this.name});
  final String? name;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Themecontroller.thememode,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky',
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode: value,
          home: Scaffold(body: name == null ? WelcomeScreen() : MainScreen()),
        );
      },
    );
  }
}
