import 'package:flutter/material.dart';
import 'help_options.dart';
import '../../core/constants/string_constants.dart';
import '../../core/enum/padding_values.dart';

import '../about_view/about_view.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("IBDb Help",
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpSection(
                                    appbarText: StringConstants().changeEMail,
                                    content: "Go to profile page and then click edit profile")));
                      },
                      child: Text(StringConstants().changeEMail, style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpSection(
                                    appbarText: "How cand look my liked books?",
                                    content: "Go to profile page and you can see liked books")));
                      },
                      child:
                          Text("How cand look my liked books?", style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpSection(
                                    appbarText: "I want to delete my account",
                                    content:
                                        "Go to profile page and then click edit profile. You can see delete my account button")));
                      },
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
