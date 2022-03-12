import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(
      {required this.fromKey,
      required this.mailController,
      required this.passController})
      : super(LoginScreenInitial());
  bool isChecked = false;
  bool isObsecure = true;

  final TextEditingController mailController;
  final TextEditingController passController;
  final GlobalKey<FormState> fromKey;

  void changeChecker(bool? value) {
    isChecked = value!;
    emit(LoginScreenInitial());
  }

  void changeObsecure() {
    isObsecure = !isObsecure;
    emit(LoginScreenInitial());
  }
}

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}
