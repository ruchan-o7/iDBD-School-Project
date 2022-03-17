import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_btn.dart';
import '../../core/custom/custom_sized_box.dart';
import '../../core/enum/padding_values.dart';
import 'sign_up_view_model.dart';
import '../../product/utils/firebase/firebase_auth.dart';

import '../../core/constants/color_constants.dart';
import '../../core/custom/input_dec_custom.dart';
import '../../product/utils/firebase/firestore_func.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordSecondController =
      TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final FocusNode nodeMail = FocusNode();
  final FocusNode nodePass = FocusNode();
  final FocusNode nodePassSecond = FocusNode();
  final FocusNode nodeUserNameSecond = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
          formKey: formKey,
          mailController: mailController,
          nodeMail: nodeMail,
          nodePass: nodePass,
          nodePassSecond: nodePassSecond,
          nodeUserNameSecond: nodeUserNameSecond,
          passController: passController,
          passwordSecondController: passwordSecondController,
          userNameController: userNameController),
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConstants().signUp),
        ),
        body: SingleChildScrollView(
          physics: (nodeMail.hasFocus ||
                  nodePass.hasFocus ||
                  nodePassSecond.hasFocus ||
                  nodeUserNameSecond.hasFocus)
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 12, right: 12, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldsMethod(context),
              Padding(
                padding: PaddingValues.medium.rawVerticalValues(context),
                child: CustomBtn(StringConstants().signIn, () async {
                  context.read<SignUpCubit>().saveUser(userNameController.text,
                      mailController.text, passController.text, context);
                  Navigator.of(context).pop();
                }, context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column TextFieldsMethod(BuildContext context) {
    return Column(
      children: [
        userNameMethod(),
        customSizedBox(context, percentageConstants().small),
        mailMethod(),
        customSizedBox(context, percentageConstants().small),
        passwordMethod(),
        customSizedBox(context, percentageConstants().small),
        passwordAgainMethod()
      ],
    );
  }

  TextFormField userNameMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodeUserNameSecond,
        controller: userNameController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().userNameHint));
  }

  TextFormField mailMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodeMail,
        controller: mailController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().eMailHint));
  }

  TextFormField passwordMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodePass,
        controller: passController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().passwordHint));
  }

  TextFormField passwordAgainMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodePassSecond,
        controller: passwordSecondController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom("${StringConstants().passwordHint} again"));
  }
}
