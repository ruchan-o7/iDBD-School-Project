enum ServicePath { baseUrl, apiKey }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.baseUrl:
        return "https://www.googleapis.com/books/v1/";
      case ServicePath.apiKey:
        return "keyes&key=AIzaSyBLexVuCT5dQxJY8tMz9hleQ3st5w4nstY";
    }
  }
}
