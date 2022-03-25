import 'package:flutter/material.dart';
import '../../core/enum/padding_values.dart';
import '../../core/theme/app_theme.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "about",
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hakkımızda"),
          centerTitle: true,
        ),
        body: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: Text(
            "asdddasdasdasdasd" * 5,
          ),
        ),
      ),
    );
  }
}
