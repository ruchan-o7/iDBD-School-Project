import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/utils/firebase/firebase_auth.dart';
import '../../product/utils/firebase/firestore_func.dart';
import 'model/signup_model.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  IAuthentication authentication = Authentication(FirebaseAuth.instance);

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
  final IFirestoreFuncs databaseFuncs =
      FirestoreFunctions(FirebaseFirestore.instance);

  Future<void> saveUser(String username, String mail, String password,
      BuildContext context) async {
    await databaseFuncs.addUserWithSet(
        userNameController.text, mailController.text, passController.text);
    await authentication.signUp(
        mailController.text, passController.text, context);
  }

  Future<void> saveUSER(UserSignUpModel model, BuildContext context) async {
    await databaseFuncs.addUserWithSetModel(model);
    Navigator.pop(context);
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
