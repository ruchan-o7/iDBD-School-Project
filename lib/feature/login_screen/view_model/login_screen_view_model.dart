import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/product/utils/firebase/firebase_auth.dart';

class SignInScreenCubit extends Cubit<SignInScreenState> {
  SignInScreenCubit({
    required this.emailController,
    required this.passwordController,
    required this.focusEmail,
    required this.focusPassword,
    required this.formKey,
  }) : super(SignInScreenInitial());
  bool isChecked = false;
  bool isObsecure = true;
  bool isLoginFail = false;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode focusEmail;
  final FocusNode focusPassword;
  bool _isCircular = false;

  void changeIsCircular() {
    _isCircular = !_isCircular;
  }

  Future<User?> sendRequest(
      String eMail, String password, BuildContext context) async {
    looseFocus();
    User? user = await Authentication()
        .eMailSignIn(eMail: eMail, password: password, context: context);
    if (user != null) {
      emit(SignInSucces(user));

      return user;
    } else {
      emit(SignInScreenInitial());
    }
  }

  void goToPage(BuildContext context, Widget destination) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => destination,
    ));
  }

  void looseFocusWithEmit() {
    focusEmail.unfocus();
    focusPassword.unfocus();
    emit(SignInScreenInitial());
  }

  void looseFocus() {
    focusEmail.unfocus();
    focusPassword.unfocus();
  }

  void changeChecker(bool? value) {
    isChecked = value!;
    emit(SignInScreenInitial());
  }

  void changeObsecure() {
    isObsecure = !isObsecure;
    emit(SignInScreenInitial());
  }
}

abstract class SignInScreenState {}

class SignInScreenInitial extends SignInScreenState {}

class SignInValidateState extends SignInScreenState {
  final bool isValidate;

  SignInValidateState(this.isValidate);
}

class SignInSucces extends SignInScreenState {
  final User model;

  SignInSucces(this.model);
}

class SignInLoadingState extends SignInScreenState {}
