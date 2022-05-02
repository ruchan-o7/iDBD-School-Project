import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({Key? key, this.onTapFunc, required this.leadingIcon, required this.text})
      : super(key: key);
  final VoidCallback? onTapFunc;
  final IconData leadingIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(text),
      ),
    );
  }
}
