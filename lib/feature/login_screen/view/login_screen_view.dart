import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/NetworkManager.dart';
import '../../blankview/blankview.dart';
import '../model/user_request_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/custom/input_dec_custom.dart';

import '../../../core/custom/login_button_custom.dart';
import '../service/i_user_service.dart';
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
  final baseUrl = "https://reqres.in/api/";

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginScreenCubit(
        formKey: formKey,
        mailController: mailController,
        passController: passController,
        service: UserLoginService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) {
          if (state is LoginSucces) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlankView(model: state.model),
            ));
          } else if (state is LoginValidateState) {
            if (state.isValidate == true) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Card(
                      child: Text("failed"),
                    );
                  });
            }
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
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
              FormBuild(_height, mailController, context, passController)
            ],
          ),
        ),
      ),
    );
  }

  Form FormBuild(
      double _height, mailController, BuildContext context, passController) {
    return Form(
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
            signInBtn(context, mailController.text, passController.text),
            SizedBox(height: _height * 0.05),
            signUpBtn()
          ],
        ));
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
          context.read<LoginScreenCubit>().sendRequest();
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
