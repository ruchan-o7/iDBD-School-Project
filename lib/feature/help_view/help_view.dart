import 'package:flutter/material.dart';
import '../../core/constants/string_constants.dart';
import '../../core/enum/padding_values.dart';

import '../about_view/about_view.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("IBDb Yardım",
            style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(StringConstants().changeEMail, style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {},
                      child:
                          Text("How cand look my liked books?", style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("I want to delete my account", style: Theme.of(context).textTheme.button)),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => const AboutView(),
                    ));
                  },
                  child: Text("About", style: Theme.of(context).textTheme.button))
            ],
          ),
        ),
      ),
    );
  }
}
