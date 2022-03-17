import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/utils/firebase/firebase_auth.dart';
import '../../product/utils/firebase/firestore_func.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
      {required this.nodeMail,
      required this.nodePass,
      required this.nodePassSecond,
      required this.nodeUserNameSecond,
      required this.formKey,
      required this.mailController,
      required this.passwordSecondController,
      required this.passController,
      required this.userNameController})
      : super(SignUpInitial());
  final FocusNode nodeMail;
  final FocusNode nodePass;
  final FocusNode nodePassSecond;
  final FocusNode nodeUserNameSecond;
  final GlobalKey<FormState> formKey;
  final TextEditingController mailController;
  final TextEditingController passwordSecondController;
  final TextEditingController passController;
  final TextEditingController userNameController;

  Future<void> saveUser(String username, String mail, String password,
      BuildContext context) async {
    await FirestoreFunctions().addUserWithSet(
        userNameController.text, mailController.text, passController.text);
    await Authentication()
        .signUp(mailController.text, passController.text, context);
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
