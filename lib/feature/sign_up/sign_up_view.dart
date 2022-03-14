import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/constants/string_constants.dart';
import 'package:school_project_ibdb/core/custom/custom_btn.dart';
import 'package:school_project_ibdb/core/custom/custom_sized_box.dart';
import 'package:school_project_ibdb/core/enum/padding_values.dart';

import '../../core/constants/color_constants.dart';
import '../../core/custom/input_dec_custom.dart';

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

  StringConstants constants = StringConstants();
  percentageConstants perconstants = percentageConstants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(constants.appName),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(constants.signIn)),
        ],
        backgroundColor: ColorConstants.secondaryColor,
      ),
      body: Padding(
        padding: PaddingValues.min.rawValues(context),
        child: SingleChildScrollView(
          physics: (nodeMail.hasFocus ||
                  nodePass.hasFocus ||
                  nodePassSecond.hasFocus ||
                  nodeUserNameSecond.hasFocus)
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldsMethod(context),
              Padding(
                padding: PaddingValues.medium.rawVerticalValues(context),
                child: CustomBtn(constants.signIn, () {}, context),
              ),
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
        customSizedBox(context, perconstants.small),
        mailMethod(),
        customSizedBox(context, perconstants.small),
        passwordMethod(),
        customSizedBox(context, perconstants.small),
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
            ? constants.enterValidMail
            : ((value ?? "").contains(".") == false)
                ? constants.enterValidMail
                : null),
        decoration: InputDecCustom(constants.userNameHint));
  }

  TextFormField mailMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodeMail,
        controller: mailController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? constants.enterValidMail
            : ((value ?? "").contains(".") == false)
                ? constants.enterValidMail
                : null),
        decoration: InputDecCustom(constants.eMailHint));
  }

  TextFormField passwordMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodePass,
        controller: passController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? constants.enterValidMail
            : ((value ?? "").contains(".") == false)
                ? constants.enterValidMail
                : null),
        decoration: InputDecCustom(constants.passwordHint));
  }

  TextFormField passwordAgainMethod() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: nodePassSecond,
        controller: passwordSecondController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? constants.enterValidMail
            : ((value ?? "").contains(".") == false)
                ? constants.enterValidMail
                : null),
        decoration: InputDecCustom("${constants.passwordHint} again"));
  }
}
