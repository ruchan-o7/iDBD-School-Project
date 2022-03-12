import 'package:dio/dio.dart';
import '../model/user_request_model.dart';
import '../model/user_response_model.dart';

abstract class IUserLoginService {
  final Dio dio;
  IUserLoginService(this.dio);
  Future<UserResponseModel?> postUserLogin(UserRequestModel model);
}

class UserLoginService extends IUserLoginService {
  UserLoginService(Dio dio) : super(dio);

//TODO: INTERCEPTOR GONNA IMPLEMENT
  @override
  Future<UserResponseModel?> postUserLogin(UserRequestModel model) async {
    final response = await dio.post("login", data: model);
    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
