import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/constants/border_radius.dart';

class NeumCont extends StatelessWidget {
  Widget child;

  NeumCont({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadiusConst.normal, color: const Color(0xFFE0E0E0), boxShadow: [
        BoxShadow(
          offset: Offset(-20, -20),
          blurRadius: 60,
          color: Colors.white.withOpacity(.7),
        ),
        BoxShadow(
          offset: Offset(20, 20),
          blurRadius: 60,
          color: Colors.white.withOpacity(.15),
        ),
      ]),
      child: child,
    );
  }
}
