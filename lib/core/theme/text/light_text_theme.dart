import 'package:flutter/material.dart';

import '../color/i_color_theme.dart';
import 'i_text_theme.dart';

class LightTextTheme implements ITextTheme {
  @override
  String? fontFamily;
  @override
  TextStyle? headline2;
  @override
  TextStyle? headline4;
  @override
  TextStyle? headline6;
  @override
  TextStyle? body1;
  @override
  TextStyle? button;
  @override
  TextStyle? body2;
  @override
  Color? primaryColor;
  @override
  AppColors getAppColors = AppColors();

  LightTextTheme() {
    headline2 = const TextStyle(fontSize: 60, fontWeight: FontWeight.w300);
    headline3 = const TextStyle(fontWeight: FontWeight.w400, fontSize: 48);
    headline4 = const TextStyle(fontSize: 34, fontWeight: FontWeight.w400);
    headline5 = const TextStyle(fontSize: 24, fontWeight: FontWeight.w400);
    headline6 = const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    body1 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    body2 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    button = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  }

  @override
  TextStyle? headline5;

  @override
  TextStyle? headline3;
}
