import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({Key? key, required this.appbarText, required this.content}) : super(key: key);
  final String appbarText;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appbarText)),
      body: Padding(
        padding: context.paddingNormal,
        child: Text(content),
      ),
    );
  }
}
