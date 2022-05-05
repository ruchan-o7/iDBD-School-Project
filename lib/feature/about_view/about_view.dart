import 'package:flutter/material.dart';
import '../../core/enum/padding_values.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: Theme.of(context).textTheme.headline3,
              ),
              Text("It's about drive, it's about power", style: Theme.of(context).textTheme.bodyText1),
            ],
          )),
    );
  }
}
