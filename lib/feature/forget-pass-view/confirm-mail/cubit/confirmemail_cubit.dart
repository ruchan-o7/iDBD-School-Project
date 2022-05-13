import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../product/utils/firebase/firebase_auth.dart';

part 'confirmemail_state.dart';

class ConfirmemailCubit extends Cubit<ConfirmemailState> {
  ConfirmemailCubit(
      {required this.formKey,
      required this.controller,
      required this.passwordController,
      required this.passNode,
      required this.codeNode})
      : super(ConfirmemailInitial());
  final GlobalKey formKey;
  final TextEditingController controller;
  final TextEditingController passwordController;
  final FocusNode passNode;
  final FocusNode codeNode;

  final _auth = Authentication();
  Future<bool> changePass(context, {required String code, required String newPassword}) async {
    return await _auth.confirmResetPass(context, code: code, newPassword: newPassword);
  }

  void looseFocus() {
    passNode.unfocus();
  }
}
