import 'package:flutter/material.dart';
import 'package:tasky/core/theme/themecontroller.dart';

ColorFilter colorFilter = Themecontroller.isDark()==true
    ? ColorFilter.mode(Color(0xffFFFCFC), BlendMode.srcIn)
    : ColorFilter.mode(Color(0xff161F1B), BlendMode.srcIn);
