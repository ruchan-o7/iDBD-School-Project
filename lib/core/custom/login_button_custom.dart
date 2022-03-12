import 'package:flutter/material.dart';

class LoginBtnCustomStyle extends ButtonStyle {
  final Color color;
  LoginBtnCustomStyle(BuildContext context, this.color)
      : super(
          elevation: MaterialStateProperty.all<double>(10),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.35,
              vertical: MediaQuery.of(context).size.height * 0.02)),
          shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
          shadowColor: MaterialStateProperty.all<Color>(color),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        );
}
