import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/blankview/blankview.dart';
import 'package:school_project_ibdb/feature/login_screen/view_model/login_screen_view_model.dart';

extension LoginSuccesStateExtnsion on LoginSucces {
  void goToPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BlankView(model: model),
    ));
  }
}
