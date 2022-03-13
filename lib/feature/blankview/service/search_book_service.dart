import 'dart:developer';

import 'package:school_project_ibdb/core/network/NetworkManager.dart';

import '../model/searched_book_model.dart';

abstract class ISearchBookService {
  NetworkManager manager;

  ISearchBookService(this.manager);

  Future<SearchBookModel?> searchByName(String nameofBook);
}

class SearchBookService extends ISearchBookService {
  SearchBookService(NetworkManager manager) : super(manager);

  @override
  Future<SearchBookModel?> searchByName(String nameofBook) async {
    final response =
        await manager.dio.get("volumes?q=${nameofBook}:${manager.apiKey}");
    inspect(response.data);

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }
}
