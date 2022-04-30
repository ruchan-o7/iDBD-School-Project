import 'package:flutter/material.dart';

class InputDecCustom extends InputDecoration {
  final Widget? iconButton;
  final String hintTextstring;
  final bool isMail;

  InputDecCustom(this.hintTextstring, {this.iconButton, this.isMail = false})
      : super(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.red,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.red,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            label: Text(hintTextstring),
            suffixIcon: iconButton == null ? null : iconButton,
            prefixIcon: isMail ? Icon(Icons.mail_outline) : null);
}
