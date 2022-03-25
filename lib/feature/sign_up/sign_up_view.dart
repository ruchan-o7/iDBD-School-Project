import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_btn.dart';
import '../../core/custom/custom_sized_box.dart';
import '../../core/enum/padding_values.dart';
import 'sign_up_view_model.dart';

import '../../core/constants/color_constants.dart';
import '../../core/custom/input_dec_custom.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConstants().signUp),
        ),
        body: SingleChildScrollView(
          physics: (context.read<SignUpCubit>().nodeMail.hasFocus ||
                  context.read<SignUpCubit>().nodePass.hasFocus ||
                  context.read<SignUpCubit>().nodePassSecond.hasFocus ||
                  context.read<SignUpCubit>().nodeUserNameSecond.hasFocus)
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
                  context.read<SignUpCubit>().saveUser(
                      context.read<SignUpCubit>().userNameController.text,
                      context.read<SignUpCubit>().mailController.text,
                      context.read<SignUpCubit>().passController.text,
                      context);
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
        userNameMethod(context),
        customSizedBox(context, percentageConstants().small),
        mailMethod(context),
        customSizedBox(context, percentageConstants().small),
        passwordMethod(context),
        customSizedBox(context, percentageConstants().small),
        passwordAgainMethod(context)
      ],
    );
  }

  TextFormField userNameMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodeUserNameSecond,
        controller: context.read<SignUpCubit>().userNameController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().userNameHint));
  }

  TextFormField mailMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodeMail,
        controller: context.read<SignUpCubit>().mailController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().eMailHint));
  }

  TextFormField passwordMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodePass,
        controller: context.read<SignUpCubit>().passController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom(StringConstants().passwordHint));
  }

  TextFormField passwordAgainMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodePassSecond,
        controller: context.read<SignUpCubit>().passwordSecondController,
        validator: ((value) => (value ?? "").contains("@") == false
            ? StringConstants().enterValidMail
            : ((value ?? "").contains(".") == false)
                ? StringConstants().enterValidMail
                : null),
        decoration: InputDecCustom("${StringConstants().passwordHint} again"));
  }
}
