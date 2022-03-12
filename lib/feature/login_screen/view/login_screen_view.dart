import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/constants/color_constants.dart';

import '../../../core/custom/login_button_custom.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({Key? key}) : super(key: key);
  final String _ibdbText = "İBDb";
  final String _e_postHint = "E-posta";
  final String _passHint = "Parola";

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.width;
    final String _stayLog = "Stay Logged in";
    final String _forgotPass = "Forgot Your Password";
    final String _signIn = "Sign in";

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
        child: Column(
          children: [
            Text(
              _ibdbText,
              style: Theme.of(context).textTheme.headline1,
            ),
            Form(
                child: Column(
              children: [
                SizedBox(height: _height * 0.05),
                TextFieldE_post(_e_postHint),
                SizedBox(height: _height * 0.05),
                TextFieldE_post(_passHint),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_stayLog),
                    TextButton(child: Text(_forgotPass), onPressed: () {}),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(_signIn, style: TextStyle(fontSize: 20)),
                  style: LoginBtnCustomStyle(context),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  TextField TextFieldE_post(String text) {
    return TextField(
        decoration: InputDecoration(
            label: Text(text),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.mail)));
  }
}
