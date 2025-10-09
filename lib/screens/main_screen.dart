import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/themecontroller.dart';
import 'package:tasky/screens/complete_screen.dart';
import 'package:tasky/screens/home_Screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompleteScreen(),
    ProfileScreen(),
  ];

  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        onTap: (value) {
          selectedindex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff15B86C),
        unselectedItemColor: Theme.of(context).textTheme.titleMedium!.color,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              colorFilter: ColorFilter.mode(
                selectedindex == 0
                    ? Color(0xff15B86C)
                    : Themecontroller.isDark() == true
                    ? Color(0xffFFFCFC)
                    : Color(0xff161F1B),
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "To Do",
            icon: SvgPicture.asset(
              "assets/images/todo.svg",
              colorFilter: ColorFilter.mode(
                selectedindex == 1
                    ? Color(0xff15B86C)
                    : Themecontroller.isDark() == true
                    ? Color(0xffFFFCFC)
                    : Color(0xff161F1B),
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Completed",
            icon: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                selectedindex == 2
                    ? Color(0xff15B86C)
                    : Themecontroller.isDark() == true
                    ? Color(0xffFFFCFC)
                    : Color(0xff161F1B),
                BlendMode.srcIn,
              ),

              "assets/images/compelete.svg",
            ),
          ),

          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                selectedindex == 3
                    ? Color(0xff15B86C)
                    : Themecontroller.isDark() == true
                    ? Color(0xffFFFCFC)
                    : Color(0xff161F1B),
                BlendMode.srcIn,
              ),

              "assets/images/profile.svg",
            ),
          ),
        ],
      ),
    );
  }
}
