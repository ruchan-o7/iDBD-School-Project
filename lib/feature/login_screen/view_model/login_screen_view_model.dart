import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_request_model.dart';
import '../model/user_response_model.dart';
import '../service/i_user_service.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit({
    required this.formKey,
    required this.mailController,
    required this.passController,
    required this.service,
  }) : super(LoginScreenInitial());
  bool isChecked = false;
  bool isObsecure = true;
  bool isLoginFail = false;

  final IUserLoginService service;
  UserResponseModel? responseModel;

  final TextEditingController mailController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;

  void changeChecker(bool? value) {
    isChecked = value!;
    emit(LoginScreenInitial());
  }

  void changeObsecure() {
    isObsecure = !isObsecure;
    emit(LoginScreenInitial());
  }

  Future<void> sendRequest() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      final responseModel = await service.postUserLogin(UserRequestModel(
          email: mailController.text, password: passController.text));
      if (responseModel is UserResponseModel) {
        emit(LoginSucces(responseModel));
      } else if (responseModel == null) {
        isLoginFail = true;
        emit(LoginValidateState(isLoginFail));
      }
      emit(LoginScreenInitial());
    }
  }
}

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class LoginValidateState extends LoginScreenState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginSucces extends LoginScreenState {
  final UserResponseModel model;

  LoginSucces(this.model);
}

class LoginLoadingState extends LoginScreenState {}
