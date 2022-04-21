import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  CustomCircleAvatar({Key? key, this.size = 40}) : super(key: key);
  double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
          ? NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}")
          : null,
      child: FirebaseAuth.instance.currentUser?.photoURL == null
          ? Image.asset("assets/icon/dummy_per.png")
          : null,
    );
  }
}
