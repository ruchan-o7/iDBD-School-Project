import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  CustomCircleAvatar({Key? key, this.size = 40, required this.avatarUrl}) : super(key: key);
  double size;
  String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: avatarUrl != null ? NetworkImage("${avatarUrl}") : null,
      child: avatarUrl == null ? Image.asset("assets/icon/dummy_per.png") : null,
    );
  }
}
