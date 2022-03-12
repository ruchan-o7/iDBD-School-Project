import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_response_model.dart';

class BlankView extends StatelessWidget {
  const BlankView({Key? key, required this.model}) : super(key: key);
  final UserResponseModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(model.token ?? "null token"),
      ),
    );
  }
}
