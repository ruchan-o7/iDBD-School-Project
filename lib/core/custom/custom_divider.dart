// Divider(
//                                 thickness: 2,
//                                 indent: context.dynamicWidth(0.1),
//                                 endIndent: context.dynamicWidth(0.1),
//                               ),

import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';

class CustomDivider extends Divider {
  CustomDivider({Key? key, required this.context})
      : super(
            key: key, endIndent: context.dynamicWidth(0.1), indent: context.dynamicWidth(0.1), thickness: 3);

  final BuildContext context;
}
