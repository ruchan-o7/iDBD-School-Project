import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class InputDecCustom extends InputDecoration {
  final Widget? iconButton;

  InputDecCustom(this.hintText, {this.iconButton})
      : super(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ColorConstants.secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ColorConstants.secondaryColor)),
          label: Text(hintText),
          suffixIcon: iconButton == null ? null : iconButton,
        );
  final String hintText;
}
