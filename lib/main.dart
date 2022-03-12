import 'package:flutter/material.dart';
import 'core/constants/color_constants.dart';

import 'feature/login_screen/view/login_screen_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          inputDecorationTheme:
              InputDecorationTheme(fillColor: ColorConstants.secondaryColor)),
      title: 'Material App',
      home: LoginScreenView(),
    );
  }
}
