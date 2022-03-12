import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(LoginScreenInitial());
}

abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}
