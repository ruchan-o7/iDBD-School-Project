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
import '../../product/utils/firebase/firebase_auth.dart';
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

  StringConstants constants = StringConstants();
  percentageConstants perconstants = percentageConstants();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConstants().appName),
          backgroundColor: ColorConstants.secondaryColor,
        ),
        body: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: SingleChildScrollView(
            physics: (nodeMail.hasFocus ||
                    nodePass.hasFocus ||
                    nodePassSecond.hasFocus ||
                    nodeUserNameSecond.hasFocus)
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldsMethod(context),
                Padding(
                  padding: PaddingValues.medium.rawVerticalValues(context),
                  child: CustomBtn(StringConstants().signIn, () async {
                    await FirestoreFunctions().addUserWithSet(
                        userNameController.text,
                        mailController.text,
                        passController.text);
                    await Authentication().signUp(
                        mailController.text, passController.text, context);
                    Navigator.of(context).pop();
                  }, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Scaffold> scaffoldBuilder(BuildContext context) async {
    return Scaffold(
      appBar: AppBar(
        title: Text(constants.appName),
        backgroundColor: ColorConstants.secondaryColor,
      ),
      body: Padding(
        padding: PaddingValues.min.rawValues(context),
        child: SingleChildScrollView(
          physics: (nodeMail.hasFocus ||
                  nodePass.hasFocus ||
                  nodePassSecond.hasFocus ||
                  nodeUserNameSecond.hasFocus)
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldsMethod(context),
              Padding(
                padding: PaddingValues.medium.rawVerticalValues(context),
                child: CustomBtn(constants.signIn, () async {
                  await Authentication().signUp(
                      mailController.text, passController.text, context);
                  Navigator.of(context).pop();
                }, context),
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
