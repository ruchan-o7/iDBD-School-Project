import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_project_ibdb/product/utils/firebase/firebase_auth.dart';

part 'forgetpass_state.dart';

class ForgetpassCubit extends Cubit<ForgetpassState> {
  ForgetpassCubit({required this.formKey, required this.controller, required this.node})
      : super(ForgetpassInitial());
  final GlobalKey formKey;
  final TextEditingController controller;
  final FocusNode node;
  final _auth = Authentication();

  Future<bool> sendResetRequest(String email, BuildContext context) async {
    emit(Processing());
    looseFocus();
    return await _auth.resetPassword(email, context);
  }

  void looseFocus() {
    emit(Processing());
    node.unfocus();
  }
}
