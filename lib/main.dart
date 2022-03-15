import 'package:flutter/material.dart';

import 'core/constants/color_constants.dart';
import 'feature/login_screen/view/sign_in_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme:
              InputDecorationTheme(fillColor: ColorConstants.secondaryColor)),
      title: 'Material App',
      home: SignInView(),
    );
  }
}
