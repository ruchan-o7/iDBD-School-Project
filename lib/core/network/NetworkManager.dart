import 'package:dio/dio.dart';
import 'package:school_project_ibdb/core/enum/service_path.dart';

class NetworkManager {
  static NetworkManager? _instace;
  static NetworkManager get instance {
    if (_instace == null) _instace = NetworkManager._init();
    return _instace!;
  }

  late final Dio dio;
  // final String _baseLoginUrl = "https://reqres.in/api";
  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: ServicePath.baseUrl.rawValue));
  }
}
