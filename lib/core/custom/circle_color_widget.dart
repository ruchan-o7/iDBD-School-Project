import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CircleShape extends StatelessWidget {
  const CircleShape({Key? key, required this.shapeColor}) : super(key: key);
  final Color shapeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.2),
      width: context.dynamicWidth(0.4),
      decoration: BoxDecoration(
          color: shapeColor,
          borderRadius: BorderRadius.circular(context.dynamicHeight(1))),
    );
  }
}
