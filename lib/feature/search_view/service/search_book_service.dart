import '../../../core/network/NetworkManager.dart';
import '../model/searched_book_model.dart';
import 'package:english_words/english_words.dart';

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
    final Iterable<String> word = nouns.take(1);
    final response = await manager.dio.get("volumes?q=$word}");

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }
}
