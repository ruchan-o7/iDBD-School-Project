import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_request_model.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_response_model.dart';
import 'package:school_project_ibdb/feature/login_screen/service/i_user_service.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit({
    required this.fromKey,
    required this.mailController,
    required this.passController,
    this.service,
  }) : super(LoginScreenInitial());
  bool isChecked = false;
  bool isObsecure = true;

  IUserLoginService? service;
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

  void sendRequest(UserRequestModel model, BuildContext context) {
    final responseModel = service?.sendRequest(model);
    if (responseModel == null) {
      emit(LoginFailedState());
    } else {
      emit(LoginSucces());
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => BlankView(),
      //     ));
    }
  }
}

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class LoginFailedState extends LoginScreenState {}

class LoginSucces extends LoginScreenState {}
