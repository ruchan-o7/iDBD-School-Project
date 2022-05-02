import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/network/network_manager.dart';
import '../../../product/base_model/book_response_mode.dart';
import '../model/searched_book_model.dart';

abstract class ISearchBookService {
  NetworkManager manager;

  ISearchBookService(this.manager);

  Future<SearchBookModel?> searchByName(String nameofBook);
  Future<SearchBookModel?> searchRandom();
  Future<BookResponseModel?> searchByCategories(String bookName, String categorieName);
  Future<BookResponseModel?> randomSearchWithCategories(String categorie);
}

class SearchBookService extends ISearchBookService {
  SearchBookService(NetworkManager manager) : super(manager);
  final Random _random = Random();

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
    final Iterable<String> word = nouns.take(200);
    final response = await manager.dio.get("volumes?q=${word.elementAt(_random.nextInt(199))}");

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<BookResponseModel?> searchByCategories(String bookName, String categorieName) async {
    final _response = await manager.dio.get("volumes?q=$bookName:subject:$categorieName");
    if (_response.statusCode == 200) {
      return BookResponseModel.fromJson(_response.data);
    }
    return null;
  }

  @override
  Future<BookResponseModel?> randomSearchWithCategories(String categorie) async {
    final Iterable<String> word = nouns.take(200);
    final _response =
        await manager.dio.get("volumes?q=${word.elementAt(_random.nextInt(199))}:subject:$categorie");
    if (_response.statusCode == 200) {
      return BookResponseModel.fromJson(_response.data);
    }
    return null;
  }
}

class GenerateRandomProfilePic {
  final _manager = NetworkManager.instance;
  final Iterable<String> _word = nouns.take(200);

  generateRandomPic() async {
    var _tempDir = await getTemporaryDirectory();
    String _fullpath = _tempDir.path + "/avatar.svg";
    await _manager.dio.download(
        "https://avatars.dicebear.com/api/bottts/${_word.elementAt(Random().nextInt(199))}.svg", _fullpath);
    return _fullpath;
  }
}
