import 'package:flutter/material.dart';
import 'help_options.dart';
import '../../core/constants/string_constants.dart';
import '../../core/enum/padding_values.dart';

import '../about_view/about_view.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);
  final appText = "IBDb Help";
  final profileHelp = "Go to profile page and then click edit profile";
  final String likedHelp = "How can I look my liked books?";
  final likeText = "Go to profile page and you can see liked books";
  final wantDelete = "I want to delete my account";
  final wantDeleteHelp =
      "Go to profile page and then click edit profile. You can see delete my account button";
  final wantDeleteAccount = "I want to delete my account";
  final bout = "about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(appText,
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
                                    appbarText: StringConstants().changeEMail, content: profileHelp)));
                      },
                      child: Text(StringConstants().changeEMail, style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpSection(appbarText: likedHelp, content: likeText)));
                      },
                      child: Text(likedHelp, style: Theme.of(context).textTheme.button)),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HelpSection(appbarText: wantDelete, content: wantDeleteHelp)));
                      },
                      child: Text(wantDeleteAccount, style: Theme.of(context).textTheme.button)),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => const AboutView(),
                    ));
                  },
                  child: Text(bout, style: Theme.of(context).textTheme.button))
            ],
          ),
        ),
      ),
    );
  }
}
