import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SignInCardView extends StatelessWidget {
  const SignInCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: context.horizontalPaddingMedium,
              child: Card(
                color: Colors.green[100],
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.dynamicWidth(0.05))),
                child: Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      Text("Log in",
                          style: Theme.of(context).textTheme.headline3),
                      Text("Welcome",
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: context.dynamicHeight(0.04),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail_outline),
                            labelText: "e-mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.dynamicWidth(0.05)))),
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: "password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.dynamicWidth(0.05)))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forget password",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                              ),
                              onPressed: () {},
                              child: const Text("Log in"),
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 2),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightGreen[200]!),
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                              ),
                              onPressed: () {},
                              child: const Text("Sign Up"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
