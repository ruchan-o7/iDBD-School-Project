import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_sized_box.dart';
import 'model/signup_model.dart';
import 'sign_up_view_model.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/color_constants.dart';
import '../../core/custom/input_dec_custom.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          return scaffolBuild(context);
        },
      ),
    );
  }

  Scaffold scaffolBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants().signUp,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        elevation: 0,
        toolbarHeight: context.dynamicHeight(0.1),
      ),
      body: SingleChildScrollView(
        physics: (context.read<SignUpCubit>().nodeMail.hasFocus ||
                context.read<SignUpCubit>().nodePass.hasFocus ||
                context.read<SignUpCubit>().nodePassSecond.hasFocus ||
                context.read<SignUpCubit>().nodeUserNameSecond.hasFocus)
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            vertical: context.dynamicHeight(0.05),
            horizontal: context.dynamicWidth(0.05)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldsMethod(context),
            SizedBox(
              height: context.dynamicHeight(0.08),
            ),
            signUpBTN(context)
          ],
        ),
      ),
    );
  }

  Row signUpBTN(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: ElevatedButton(
          onPressed: () {
            context.read<SignUpCubit>().saveUSER(
                UserSignUpModel(
                    imageUrl: "",
                    signDate: DateTime.now().toString(),
                    userMail: context.read<SignUpCubit>().mailController.text,
                    userName:
                        context.read<SignUpCubit>().userNameController.text,
                    userPassword:
                        context.read<SignUpCubit>().passController.text,
                    userUID: ""),
                context);
          },
          child: Text("Sign Up", style: Theme.of(context).textTheme.headline5),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(context.verticalPaddingNormal),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(context.dynamicWidth(0.02))))),
        ))
      ],
    );
  }

  Widget TextFieldsMethod(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          userNameMethod(context),
          customSizedBox(context, percentageConstants().small),
          mailMethod(context),
          customSizedBox(context, percentageConstants().small),
          passwordMethod(context),
          customSizedBox(context, percentageConstants().small),
          passwordAgainMethod(context)
        ],
      ),
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
