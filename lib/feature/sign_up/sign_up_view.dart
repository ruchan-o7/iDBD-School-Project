import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_sized_box.dart';
import '../../core/custom/input_dec_custom.dart';
import '../../product/utils/validator/validator.dart';
import 'sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  bool _isPressed = false;
  changeVisuality() {
    _isPressed = !_isPressed;
  }

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
        toolbarHeight: context.dynamicHeight(0.08),
      ),
      body: SingleChildScrollView(
        physics: (context.read<SignUpCubit>().nodeMail.hasFocus ||
                context.read<SignUpCubit>().nodePass.hasFocus ||
                context.read<SignUpCubit>().nodePassSecond.hasFocus ||
                context.read<SignUpCubit>().nodeUserName.hasFocus)
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            vertical: context.dynamicHeight(0.05), horizontal: context.dynamicWidth(0.05)),
        child: GestureDetector(
          onTap: () {
            context.read<SignUpCubit>().looseFocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userInputs(context),
              SizedBox(
                height: context.dynamicHeight(0.08),
              ),
              signUpBTN(context)
            ],
          ),
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
          onPressed: context.read<SignUpCubit>().isPressed == false
              ? () {
                  context.read<SignUpCubit>().saveUSER(context);
                }
              : null,
          child: Text("Sign Up", style: Theme.of(context).textTheme.headline5),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(context.verticalPaddingNormal),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.dynamicWidth(0.02))))),
        ))
      ],
    );
  }

  Widget userInputs(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      autovalidateMode: (context.read<SignUpCubit>().nodeMail.hasFocus ||
              context.read<SignUpCubit>().nodePass.hasFocus ||
              context.read<SignUpCubit>().nodeUserName.hasFocus ||
              context.read<SignUpCubit>().nodePassSecond.hasFocus)
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          CustomSizedBox(context, PercentageConstants().small),
          userNameMethod(context),
          CustomSizedBox(context, PercentageConstants().small),
          mailMethod(context),
          CustomSizedBox(context, PercentageConstants().small),
          passwordMethod(context),
          CustomSizedBox(context, PercentageConstants().small),
          passwordAgainMethod(context)
        ],
      ),
    );
  }

  TextFormField userNameMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        // cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodeUserName,
        controller: context.read<SignUpCubit>().userNameController,
        validator: ((value) => Validator().validatePassword(password: value)),
        decoration: InputDecCustom(StringConstants().userNameHint));
  }

  TextFormField mailMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        // cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodeMail,
        controller: context.read<SignUpCubit>().mailController,
        validator: (v) => Validator().validateEmail(email: v),
        decoration: InputDecCustom(StringConstants().eMailHint));
  }

  TextFormField passwordMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        // cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodePass,
        controller: context.read<SignUpCubit>().passController,
        validator: (v) => Validator().validatePassword(password: v),
        decoration: InputDecCustom(StringConstants().passwordHint));
  }

  TextFormField passwordAgainMethod(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        // cursorColor: ColorConstants.secondaryColor,
        focusNode: context.read<SignUpCubit>().nodePassSecond,
        controller: context.read<SignUpCubit>().passwordSecondController,
        validator: (v) => Validator().validatePassword(password: v),
        decoration: InputDecCustom("${StringConstants().passwordHint} again"));
  }
}
