import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/utils/firebase/firebase_auth.dart';
import '../../product/utils/firebase/firestore_func.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final FocusNode nodeMail = FocusNode();
  final FocusNode nodePass = FocusNode();
  final FocusNode nodePassSecond = FocusNode();
  final FocusNode nodeUserNameSecond = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordSecondController =
      TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

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
