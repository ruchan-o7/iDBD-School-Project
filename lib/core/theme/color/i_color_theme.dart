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
  // final textfieldColor = const Color(0xfff4f2f4);

  // final lightGreen = Colors.lightGreen[200]!;
  // final moreLigtGreen = Colors.green[100];
  // final green = (Colors.green[900]);
  // final turqoz = const Color(0xff4ad2b8);
  /*----------------------------------------*/
  // final white = Colors.white;
  // final appleBlossom = const Color(0xffDEBA9D);
  // final neapolitan = const Color(0xff9E7777);
  // final prussianPlum = const Color(0xff6F4C5B);
  // final black = const Color(0xff000000);
  // final lightRed = const Color(0xffD45555);
  // final red = const Color.fromARGB(255, 255, 0, 0);
  // final scaffoldColor = const Color(0xffFDFDFD);
  // final darkScaffoldColor = const Color(0xff19191B);
  // final darkThemeTextColor = const Color(0xffFFFFFF);
  // final lightThemeTextColor = const Color(0xff19191B);
  // final headline6Color = const Color(0xff9D9D9D);
}
