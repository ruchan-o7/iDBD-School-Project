import 'dart:math';

import '../../../core/network/NetworkManager.dart';
import '../model/searched_book_model.dart';

abstract class ISearchBookService {
  NetworkManager manager;

  ISearchBookService(this.manager);

  Future<SearchBookModel?> searchByName(String nameofBook);
  Future<SearchBookModel?> searchRandom();
}

class SearchBookService extends ISearchBookService {
  SearchBookService(NetworkManager manager) : super(manager);

  @override
  Future<SearchBookModel?> searchByName(String nameofBook) async {
    final response = await manager.dio.get("volumes?q=intitle:$nameofBook}");

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<SearchBookModel?> searchRandom() async {
    final response = await manager.dio.get("volumes?q=${getRandomString()}}"); //!: Random kelime üretemiyor

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }

  String getRandomString() =>
      String.fromCharCodes(Iterable.generate(8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  static const String _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
  Random _rnd = Random();
}
