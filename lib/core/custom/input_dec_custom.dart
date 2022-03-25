import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InputDecCustom extends InputDecoration {
  final Widget? iconButton;
  final String hintTextstring;

  InputDecCustom(this.hintTextstring, {this.iconButton})
      : super(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            // borderSide: BorderSide(color: AppTheme().myTheme.backgroundColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            // borderSide: BorderSide(color: AppTheme().myTheme.backgroundColor),
          ),
          label: Text(hintTextstring),
          suffixIcon: iconButton == null ? null : iconButton,
        );
}
