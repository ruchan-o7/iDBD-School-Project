import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/constants/logo_path.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key, this.size = 40, required this.avatarUrl}) : super(key: key);
  final double size;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: avatarUrl != null ? NetworkImage("$avatarUrl") : null,
      child: avatarUrl == null ? Image.asset(LogoPaths.dummyPer) : null,
    );
  }
}
