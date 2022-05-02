import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChangePassView extends StatelessWidget {
  ChangePassView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    labelText: 'Old Password',
                    hintText: 'New  Password',
                  )),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      labelText: 'New  Password',
                      hintText: 'New  Password',
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      labelText: 'New  Password Again',
                      hintText: 'New  Password Again',
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: context.horizontalPaddingHigh,
                          child: ElevatedButton(
                            child: const Text('Apply'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
