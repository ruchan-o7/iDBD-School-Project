import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/constants/string_constants.dart';
import 'package:school_project_ibdb/core/enum/padding_values.dart';

import '../about_view/about_view.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("IBDb Yardım",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(fontWeight: FontWeight.bold)),
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
                      child: Text(StringConstants().howCanISignUp)),
                  const Divider(
                    thickness: 2,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(StringConstants().forgetPassword)),
                  const Divider(
                    thickness: 2,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(StringConstants().changeEMail)),
                  const Divider(
                    thickness: 2,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Beğendiğim kitaplara nasıl bakarım?")),
                  const Divider(
                    thickness: 2,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Hesap kapatmak istiyorum")),
                ],
              ),
              Hero(
                  tag: "about",
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) => const AboutView(),
                        ));
                      },
                      child: const Text("Hakkımızda")))
            ],
          ),
        ),
      ),
    );
  }
}
