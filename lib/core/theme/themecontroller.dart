import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';

class Themecontroller {
  static ValueNotifier<ThemeMode> thememode = ValueNotifier(ThemeMode.light);
  bool _result = true;
  void init() {
    _result = PrefrenceManager().getbool("theme") ?? true;

    if (_result == true) {
      thememode.value = ThemeMode.dark;
    } else {
      thememode.value = ThemeMode.light;
    }
  }

  void toggel() async {
    _result = PrefrenceManager().getbool("theme") ?? true;

    if (_result == true) {
      thememode.value = ThemeMode.light;
      await PrefrenceManager().setbool("theme", false);
    } else {
      thememode.value = ThemeMode.dark;
      await PrefrenceManager().setbool("theme", true);
    }
  }

 static bool isDark() {
    return thememode.value == ThemeMode.dark;
  }
}
