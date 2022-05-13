import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../core/constants/logo_path.dart';
import '../../../core/custom/circle_color_widget.dart';
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
  bool isLibrary = false;
  Authentication authentication = Authentication();

  void changeIsCircular() {
    _isCircular = !_isCircular;
  }

  void changeApperance(bool v) {
    isLibrary = v;
    emit(SignUpViewState());
  }

  void goToSignUpPage(BuildContext context) {
    emit(SignUpViewState());
  }

  Future<void> init() async {
    emit(LoadedFirebaseState());
    await authentication.initializeFirebase();
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

  Widget changeBackground(BuildContext context) {
    if (isLibrary) {
      return SizedBox(
          height: context.dynamicHeight(1),
          child: Image.asset(
            LogoPaths.kutuphaneCumhur,
            fit: BoxFit.cover,
          ));
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              child: const CircleShape(
                shapeColor: Colors.teal,
              ),
              bottom: context.dynamicHeight(0.69)),
          Positioned(
            bottom: context.dynamicHeight(0.15),
            child: const CircleShape(shapeColor: Colors.green),
          ),
          Positioned(child: const CircleShape(shapeColor: Colors.blue), left: context.dynamicWidth(0.5)),
        ],
      );
    }
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
