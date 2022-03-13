import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/searched_book_model.dart';

abstract class ISearchBookService {
  final Dio dio;

  ISearchBookService(this.dio);

  Future<SearchBookModel?> searchByName(String nameofBook);
}

class SearchBookService extends ISearchBookService {
  SearchBookService(Dio dio) : super(dio);

  @override
  Future<SearchBookModel?> searchByName(String nameofBook) async {
    final response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=intibah:keyes&key=AIzaSyBLexVuCT5dQxJY8tMz9hleQ3st5w4nstY");
    inspect(response.data);

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }
}
