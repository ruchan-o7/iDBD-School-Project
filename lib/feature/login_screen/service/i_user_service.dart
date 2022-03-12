import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_request_model.dart';
import 'package:school_project_ibdb/feature/login_screen/model/user_response_model.dart';

abstract class IUserLoginService {
  final Dio dio;
  IUserLoginService(this.dio);
  Future<UserResponseModel?> sendRequest(UserRequestModel model);
}

class UserLoginService extends IUserLoginService {
  UserLoginService(Dio dio) : super(dio);

  @override
  Future<UserResponseModel?> sendRequest(UserRequestModel model) async {
    UserResponseModel? resModel;
    try {
      final response = await dio.post("register",
          data: UserRequestModel.fromJson(model.toJson()));
      log("user sended: ${response.data}");
      if (response.statusCode == 200) {
        resModel = UserResponseModel.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return resModel;
  }
}
