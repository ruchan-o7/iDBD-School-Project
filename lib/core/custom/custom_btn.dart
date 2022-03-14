import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'login_button_custom.dart';

class CustomBtn extends ElevatedButton {
  final String text;
  final VoidCallback onTap;
  final BuildContext context;

  CustomBtn(
    this.text,
    this.onTap,
    this.context, {
    Key? key,
  }) : super(
            key: key,
            onPressed: onTap,
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
            style: LoginBtnCustomStyle(context, ColorConstants.secondaryColor));
}
