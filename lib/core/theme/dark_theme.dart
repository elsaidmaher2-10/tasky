import 'package:flutter/material.dart';

ThemeData darktheme = ThemeData(
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828)),
  checkboxTheme: CheckboxThemeData(side: BorderSide(color: Color(0xff6E6E6E))),
  brightness: Brightness.dark,
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
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    backgroundColor: Color(0xff181818),
  ),
  scaffoldBackgroundColor: Color(0xff181818),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xffFFFFFF),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xffFFFFFF),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xffFFFFFF),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(fontSize: 16, color: Colors.white),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,

    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
    fillColor: Color(0xff282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
  bottomAppBarTheme: BottomAppBarThemeData(color: Color(0xff181818)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    elevation: 3,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff6D6D6D)),
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
  ),
  dialogTheme: DialogThemeData(
    contentTextStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white)),
  ),
);
