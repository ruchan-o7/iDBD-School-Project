import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_project_ibdb/product/random_pic_generator/random_pict_generator.dart';
import '../../core/constants/logo_path.dart';

class CustomCircleAvatar extends StatefulWidget {
  CustomCircleAvatar({Key? key, this.size = 40, required this.avatarUrl}) : super(key: key);
  final double size;
  final String? avatarUrl;
  late String avatarUri;

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
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
  void initState() {
    super.initState();
    getUriFromCache();
  }

  getUriFromCache() async {
    widget.avatarUri = await GenerateRandomProfilePic().generateRandomPic();
  }

  @override
  Widget build(BuildContext context) {
    return validatePhoto(widget.avatarUrl)
        ? CircleAvatar(
            radius: widget.size,
            backgroundImage: validatePhoto(widget.avatarUrl) ? NetworkImage("${widget.avatarUrl}") : null,
            child: validatePhoto(widget.avatarUrl) ? null : Image.asset(LogoPaths.dummyPer),
          )
        : CircleAvatar(
            radius: widget.size,
            backgroundColor: Colors.transparent,
            child: SvgPicture.file(File("/data/user/0/com.example.school_project_ibdb/cache/avatar.svg")));
  }
}
