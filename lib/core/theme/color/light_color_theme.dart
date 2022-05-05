import 'package:flutter/material.dart';

import 'i_color_theme.dart';

class LightColorTheme implements IColorTheme {
  @override
  late final Color? appBarColor;

  @override
  late final Brightness? brightness;

  @override
  late final ColorScheme? colorScheme;

  @override
  late final Color? textfield;

  @override
  AppColors colors = AppColors();

  LightColorTheme() {
    appBarColor = colors.scaffoldColor;
    iconColor = colors.moreDarkerColor;
    moreDarkerColor = colors.moreDarkerColor;
    primaryColor = colors.primaryColor;
    secondaryColor = colors.secondaryColor;
    thirdColor = colors.thirdColor;
    cardColor = colors.secondaryColor;

    scaffoldBackgroundColor = colors.scaffoldColor;
    // backgroundColor = colors.scaffoldColor;
    textfield = colors.textfieldColor;
    brightness = Brightness.light;

    iconThemeData = ThemeData.light().iconTheme.copyWith(
          // color: colors.moreDarkerColor,
          color: colors.thirdColor,
        );
    colorScheme = const ColorScheme.light().copyWith(
      onPrimary: colors.primaryColor,
      primary: colors.primaryColor,
      background: colors.scaffoldColor,
      secondary: colors.secondaryColor,
      tertiary: colors.thirdColor,
      surface: colors.moreDarkerColor, //--> navbardaki iconların rengibi belirliyo
      shadow: colors.primaryColor,
    );
  }

  @override
  late final Color? cardColor;

  @override
  late final Color? iconColor;

  @override
  late final Color? scaffoldBackgroundColor;

  @override
  late final Color? moreDarkerColor;

  @override
  late final Color? primaryColor;

  @override
  late final Color? secondaryColor;

  @override
  late final Color? thirdColor;

  @override
  IconThemeData? iconThemeData;
}
