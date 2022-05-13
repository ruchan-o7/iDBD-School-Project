import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/utils/firebase/firebase_auth.dart';
import '../../nav_bar/nav_bar_view.dart';

class LoginCardCubit extends Cubit<LoginCardState> {
  LoginCardCubit() : super(LoginCardInitial()) {
    init();
  }
  bool isChecked = false;
  bool isObsecure = true;
  bool isLoginFail = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  bool _isCircular = false;
  Authentication authentication = Authentication();

  void changeIsCircular() {
    _isCircular = !_isCircular;
  }

  void goToSignUpPage(BuildContext context) {
    emit(SignUpViewState());
  }

  Future<void> init() async {
    emit(LoadedFirebaseState());
    await authentication.initializeFirebase();
    // FirebaseApp firebaseApp = await authentication.initializeFirebase();
    emit(LoadedFirebaseState());
  }

  Future<User?> sendRequest(String eMail, String password, BuildContext context) async {
    looseFocus();
    emit(LoginLoading());
    User? user = await authentication.eMailSignIn(eMail: eMail, password: password, context: context);
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavBar(),
      ));
      emit(LoginSucces(user));

      return user;
    } else {}
    return null;
  }

  void goToPage(BuildContext context, Widget destination) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => destination,
    ));
  }

  void looseFocusWithEmit() {
    focusEmail.unfocus();
    focusPassword.unfocus();
    emit(LoginCardInitial());
  }

  void looseFocus() {
    focusEmail.unfocus();
    focusPassword.unfocus();
  }

  void changeChecker(bool? value) {
    isChecked = value!;
    emit(LoginCardInitial());
  }

  void changeObsecure() {
    isObsecure = !isObsecure;
    emit(LoginCardInitial());
  }
}

class LoginCardInitial extends LoginCardState {}

abstract class LoginCardState {}

class LoginSucces extends LoginCardState {
  final User model;

  LoginSucces(this.model);
}

class LoginLoading extends LoginCardState {}

class LoadingFirebaseState extends LoginCardState {}

class LoadedFirebaseState extends LoginCardState {}

class SignUpViewState extends LoginCardState {}
