import 'package:flutter/material.dart';

abstract class IColorTheme {
  AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? primaryColor;
  Color? secondaryColor;
  Color? thirdColor;
  Color? moreDarkerColor;
  Brightness? brightness;
  ColorScheme? colorScheme;
  Color? textfield;
  Color? cardColor;
  Color? iconColor;
  IconThemeData? iconThemeData;
}

class AppColors {
  final white = const Color(0xffffffff);
  final scaffoldColor = const Color(0xffEAF2CE);
  final primaryColor = const Color(0xff53A62D);
  final secondaryColor = const Color(0xffB6D96A);
  final thirdColor = const Color(0xff9CD918);
  final moreDarkerColor = const Color(0xff707365);
  final textfieldColor = Colors.white60;
//-------------------------------------
  // final backgroundAndScaffoldColor = const Color(0xffF2F2F2);
  // final secondary = Color.fromARGB(255, 203, 203, 203);
  // final primary = const Color(0xffF2CB05);
  // final black = const Color(0xff0D0D0D);
  // final navBarItem = const Color(0xffF24738);
//-------------------------------------
  final backgroundAndScaffoldColor = const Color(0xffEBF0F2);
  final secondary = Color(0xffD9D9D9);
  final primary = const Color(0xff5A6E73);
  final black = const Color(0xff313E40);
  final navBarItem = const Color(0xff8FA1A6);
}
