import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChangeUserName extends StatefulWidget {
  ChangeUserName({Key? key}) : super(key: key);

  @override
  State<ChangeUserName> createState() => _ChangeUserNameState();
}

class _ChangeUserNameState extends State<ChangeUserName> {
  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> changeName() async {
    await FirebaseAuth.instance.currentUser
        ?.updateDisplayName(_controller.text);
    _controller.text = "";
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Change User Name",
              style: Theme.of(context).textTheme.headline5),
        ),
        body: Padding(
          padding: context.paddingMedium,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: context.horizontalPaddingHigh,
                        child: ElevatedButton(
                            onPressed: changeName, child: const Text("Apply")),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
