import 'package:flutter/material.dart';

import '../constants/border_radius.dart';

class InputDecCustom extends InputDecoration {
  final Widget? iconButton;
  final String hintTextstring;
  final bool isMail;

  InputDecCustom(this.hintTextstring, {this.iconButton, this.isMail = false})
      : super(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadiusConst.normal,
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadiusConst.normal,
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadiusConst.normal,
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadiusConst.normal,
            ),
            label: Text(hintTextstring),
            suffixIcon: iconButton,
            prefixIcon: isMail ? const Icon(Icons.mail_outline) : null);
}
