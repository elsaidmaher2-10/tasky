import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(width: 2, color: Color(0xffD1DAD6)),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(primaryContainer: Color(0xffFFFFFF)),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateColor.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }

      return Colors.white;
    }),

    trackOutlineWidth: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return 0;
      }
      return 3;
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
    }),

    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
    }),
  ),
  appBarTheme: AppBarTheme(
    foregroundColor: Color(0xffF6F7F9),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    backgroundColor: Color(0xffF6F7F9),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xff3A4642),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(fontSize: 16, color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,

    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    focusColor: Color(0xffD1DAD6),
    fillColor: Color(0xffFFFFFF),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
  ),
  splashFactory: NoSplash.splashFactory,
  bottomAppBarTheme: BottomAppBarThemeData(
    color: Color(0xffF6F7F9),
    elevation: 0,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    elevation: 3,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
  ),
  dialogTheme: DialogThemeData(
    insetPadding: EdgeInsets.all(16),
    contentTextStyle: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black)),
  ),
);
