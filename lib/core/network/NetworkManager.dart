import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instace;
  static NetworkManager get instance {
    if (_instace == null) _instace = NetworkManager._init();
    return _instace!;
  }

  late final Dio dio;
  final String _baseLoginUrl = "https://reqres.in/api";
  final String _baseUrl = "https://www.googleapis.com/books/v1/";
  final String apiKey = "keyes&key=AIzaSyBLexVuCT5dQxJY8tMz9hleQ3st5w4nstY";
  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }
}
