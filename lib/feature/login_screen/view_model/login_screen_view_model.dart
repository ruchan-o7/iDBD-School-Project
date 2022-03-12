import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_request_model.dart';
import '../model/user_response_model.dart';
import '../service/i_user_service.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit({
    required this.fromKey,
    required this.mailController,
    required this.passController,
    required this.service,
  }) : super(LoginScreenInitial());
  bool isChecked = false;
  bool isObsecure = true;

  final IUserLoginService service;
  UserResponseModel? responseModel;

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

  Future<void> sendRequest() async {
    emit(LoginLoadingState());
    final responseModel = await service.postUserLogin(UserRequestModel(
        email: mailController.text, password: passController.text));
    if (responseModel == null) {
      emit(LoginFailedState());
    } else {
      emit(LoginSucces());
    }
  }
}

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class LoginFailedState extends LoginScreenState {}

class LoginSucces extends LoginScreenState {}

class LoginLoadingState extends LoginScreenState {}
