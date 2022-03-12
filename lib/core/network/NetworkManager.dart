import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instace;
  static NetworkManager get instance {
    if (_instace == null) _instace = NetworkManager._init();
    return _instace!;
  }

  late final Dio dio;
  String _baseurl = "https://reqres.in/api";

  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: _baseurl));
  }
}
