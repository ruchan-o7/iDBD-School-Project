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
    appBarColor = colors.backgroundAndScaffoldColor;
    iconColor = colors.black;
    moreDarkerColor = colors.black;
    primaryColor = colors.primary;
    secondaryColor = colors.secondary;
    thirdColor = colors.secondary;
    cardColor = colors.backgroundAndScaffoldColor;

    scaffoldBackgroundColor = colors.backgroundAndScaffoldColor;
    // backgroundColor = colors.scaffoldColor;
    textfield = colors.textfieldColor;
    brightness = Brightness.light;

    iconThemeData = ThemeData.light().iconTheme.copyWith(
          // color: colors.moreDarkerColor,
          color: colors.black,
        );
    colorScheme = const ColorScheme.light().copyWith(
      onPrimary: colors.primaryColor,
      primary: colors.primary,
      background: colors.primary,
      secondary: colors.secondaryColor,
      tertiary: colors.thirdColor,
      surface: colors.black, //--> navbardaki iconların rengibi belirliyo
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
