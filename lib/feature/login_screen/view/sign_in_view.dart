import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/core/constants/string_constants.dart';
import 'package:school_project_ibdb/core/custom/custom_btn.dart';
import 'package:school_project_ibdb/core/custom/custom_sized_box.dart';
import 'package:school_project_ibdb/core/enum/padding_values.dart';
import 'package:school_project_ibdb/feature/sign_up/sign_up_view.dart';
import '../../../core/custom/input_dec_custom.dart';

import '../../../product/utils/firebase/firebase_auth.dart';
import '../view_model/login_screen_view_model.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  bool isChecked = false;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInScreenCubit(
          emailController: emailController,
          focusEmail: focusEmail,
          focusPassword: focusPassword,
          formKey: formkey,
          passwordController: passwordController),
      child: BlocConsumer<SignInScreenCubit, SignInScreenState>(
        listener: (context, state) {
          if (state is SignInSucces) {}
        },
        builder: (context, state) {
          return BlocConsumer<SignInScreenCubit, SignInScreenState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<SignInScreenCubit>().looseFocus();
                },
                child: Scaffold(
                  body: FutureBuilder(
                    future:
                        Authentication().initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Padding(
                          padding: PaddingValues.min.rawValues(context),
                          child: Column(
                            children: [
                              customSizedBox(context, 10),
                              Text(StringConstants().appName,
                                  style: Theme.of(context).textTheme.headline1),
                              Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    mailTextField(),
                                    customSizedBox(
                                        context, percentageConstants().small),
                                    passwordTextfield(),
                                  ],
                                ),
                              ),
                              forgetPassText(context),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: percentageConstants().medium),
                                child: CustomBtn(StringConstants().signIn,
                                    () async {
                                  context
                                      .read<SignInScreenCubit>()
                                      .looseFocus();
                                  User? user = await context
                                      .read<SignInScreenCubit>()
                                      .sendRequest(emailController.text,
                                          passwordController.text, context);
                                  if (user != null) {
                                    inspect(user);
                                  }
                                }, context),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Row forgetPassText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              context.read<SignInScreenCubit>().goToPage(context, SignUpView());
            },
            child: Text(StringConstants().forgetPassword))
      ],
    );
  }

  TextFormField mailTextField() {
    return TextFormField(
      controller: emailController,
      focusNode: focusEmail,
      decoration: InputDecCustom(StringConstants().eMailHint),
    );
  }

  TextFormField passwordTextfield() {
    return TextFormField(
      controller: passwordController,
      focusNode: focusPassword,
      decoration: InputDecCustom(StringConstants().passwordHint),
    );
  }

  customSizedBox spacerWidget(BuildContext context) {
    return customSizedBox(context, percentageConstants().medium);
  }
}
