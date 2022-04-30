import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomDivider extends Divider {
  CustomDivider({Key? key, required this.context})
      : super(
            key: key, endIndent: context.dynamicWidth(0.1), indent: context.dynamicWidth(0.1), thickness: 3);

  final BuildContext context;
}
