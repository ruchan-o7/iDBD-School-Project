import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
