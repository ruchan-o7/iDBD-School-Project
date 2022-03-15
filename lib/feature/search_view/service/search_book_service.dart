import '../../../core/enum/service_path.dart';

import '../../../core/network/NetworkManager.dart';
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
    final response = await manager.dio
        .get("volumes?q=$nameofBook:${ServicePath.apiKey.rawValue}");

    if (response.statusCode == 200) {
      return SearchBookModel.fromJson(response.data);
    }
    return null;
  }
}
