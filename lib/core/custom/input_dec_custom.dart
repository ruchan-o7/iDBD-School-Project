import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class InputDecCustom extends InputDecoration {
  final Widget? iconButton;

  InputDecCustom(this.hintText, {this.iconButton})
      : super(
            fillColor: ColorConstants.secondaryColor,
            label: Text(hintText),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: iconButton == null ? null : iconButton);
  final String hintText;
}
