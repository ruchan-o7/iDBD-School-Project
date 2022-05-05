import 'package:flutter/material.dart';

import 'color/i_color_theme.dart';
import 'color/light_color_theme.dart';
import 'text/i_text_theme.dart';
import 'text/light_text_theme.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColorTheme get colorTheme;
}

class AppThemeLight extends ITheme {
  @override
  IColorTheme get colorTheme => LightColorTheme();

  @override
  ITextTheme get textTheme => LightTextTheme();
}

abstract class ThemeManager {
  static ThemeData createThemeData(ITheme theme) {
    return ThemeData(
      indicatorColor: theme.colorTheme.primaryColor,
      primaryColor: theme.colorTheme.primaryColor,
      scaffoldBackgroundColor: theme.colorTheme.scaffoldBackgroundColor,
      buttonTheme: ThemeData.light().buttonTheme.copyWith(
            buttonColor: theme.colorTheme.primaryColor,
            colorScheme: theme.colorTheme.colorScheme,
          ),
      cardColor: theme.colorTheme.cardColor,
      iconTheme: theme.colorTheme.iconThemeData,
      brightness: theme.colorTheme.brightness,
      canvasColor: theme.colorTheme.thirdColor,
      shadowColor: theme.colorTheme.moreDarkerColor,
      backgroundColor: theme.colorTheme.primaryColor,
      fontFamily: theme.textTheme.fontFamily,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: theme.textTheme.headline2,
            headline4: theme.textTheme.headline4,
            headline6: theme.textTheme.headline6,
            bodyText1: theme.textTheme.body1,
            bodyText2: theme.textTheme.body2,
            button: theme.textTheme.button,
          ),

      navigationBarTheme: ThemeData.light().navigationBarTheme.copyWith(
          indicatorColor: theme.colorTheme.moreDarkerColor,
          backgroundColor: theme.colorTheme.primaryColor,
          iconTheme:
              MaterialStateProperty.all<IconThemeData?>(IconThemeData(color: theme.colorTheme.primaryColor))),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            color: theme.colorTheme.appBarColor,
            iconTheme: theme.colorTheme.iconThemeData,
          ),

      // appBarTheme: AppBarTheme(color: theme.colorTheme.appBarColor),
      floatingActionButtonTheme: ThemeData.light().floatingActionButtonTheme.copyWith(
            backgroundColor: theme.colorTheme.primaryColor,
          ),
      colorScheme: theme.colorTheme.colorScheme,
    );
  }
}
