import 'package:flutter/material.dart';
import '../../core/constants/logo_path.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key, this.size = 40, required this.avatarUrl}) : super(key: key);
  final double size;
  final String? avatarUrl;
  bool validatePhoto(String? avatarUrl) {
    if (avatarUrl == null) {
      return false;
    } else if (avatarUrl == "") {
      return false;
    } else if (avatarUrl == " ") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: validatePhoto(avatarUrl) ? NetworkImage("$avatarUrl") : null,
      child: validatePhoto(avatarUrl) ? null : Image.asset(LogoPaths.dummyPer),
    );
  }
}
