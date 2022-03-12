import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/blankview/blankview.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_request_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/custom/input_dec_custom.dart';

import '../../../core/custom/login_button_custom.dart';
import '../view_model/login_screen_view_model.dart';

class LoginScreenView extends StatelessWidget {
  LoginScreenView({Key? key}) : super(key: key);
  final String _ibdbText = "İBDb";
  final String _e_postHint = "E-posta";
  final String _passHint = "Parola";
  final String _stayLog = "Stay Logged in";
  final String _forgotPass = "Forgot Your Password";
  final String _signIn = "Sign in";
  final String _signUp = "Still not member Sign up";
  bool isChecked = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode nodeMail = FocusNode();
  final FocusNode nodePass = FocusNode();

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginScreenCubit(
        fromKey: formKey,
        mailController: mailController,
        passController: passController,
      ),
      child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoginSucces) {
            return BlankView();
          } else {
            return ScaffoldMethod(
                _width, _height, context, mailController, passController);
          }
        },
      ),
    );
  }

  Scaffold ScaffoldMethod(double _width, double _height, BuildContext context,
      mailController, passController) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          physics: (nodeMail.hasFocus || nodePass.hasFocus)
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: _height * 0.2),
              Text(_ibdbText, style: Theme.of(context).textTheme.headline1),
              Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, //TODO: REFACTOR WITH STATE CONTROL
                  child: Column(
                    children: [
                      SizedBox(height: _height * 0.05),
                      mailFormField(mailController, context),
                      SizedBox(height: _height * 0.05),
                      passFormField(passController, context),
                      SizedBox(height: _height * 0.05),
                      optionsRow(context),
                      SizedBox(height: _height * 0.05),
                      signInBtn(
                          context, mailController.text, passController.text),
                      SizedBox(height: _height * 0.05),
                      signUpBtn()
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Row optionsRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        checkBox(context),
        Text(_stayLog),
      ]),
      forgotPassBtn(),
    ]);
  }

  TextButton signUpBtn() => TextButton(onPressed: () {}, child: Text(_signUp));

  ElevatedButton signInBtn(BuildContext context, String mail, String password) {
    //asdasd
    return ElevatedButton(
        onPressed: () {
          context.read<LoginScreenCubit>().sendRequest(
              UserRequestModel(email: mail, password: password), context);
        },
        child: Text(_signIn, style: const TextStyle(fontSize: 20)),
        style: LoginBtnCustomStyle(context, ColorConstants.secondaryColor));
  }

  TextButton forgotPassBtn() {
    return TextButton(child: Text(_forgotPass), onPressed: () {});
  }

  Checkbox checkBox(BuildContext context) {
    return Checkbox(
      fillColor:
          MaterialStateProperty.all<Color>(ColorConstants.secondaryColor),
      value: context.read<LoginScreenCubit>().isChecked,
      onChanged: (val) {
        context.read<LoginScreenCubit>().changeChecker(val);
      },
    );
  }

  Widget passFormField(passController, BuildContext context) {
    bool val = context.read<LoginScreenCubit>().isObsecure;
    return TextFormField(
      controller: passController,
      focusNode: nodePass,
      obscureText: val,
      decoration: InputDecCustom(_passHint,
          iconButton: IconButton(
              icon: Icon(
                  val ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
              onPressed: () {
                context.read<LoginScreenCubit>().changeObsecure();
              })),
    );
  }

  TextFormField mailFormField(mailController, context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodeMail,
        controller: mailController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? "Please enter valid mail"
            : ((value ?? "").contains(".") == false)
                ? "Please enter valid mail"
                : null),
        decoration: InputDecCustom(_e_postHint));
  }
}
