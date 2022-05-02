import 'package:flutter_test/flutter_test.dart';
import 'package:school_project_ibdb/core/network/network_manager.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';

void main() {
  ISearchBookService service = SearchBookService(NetworkManager.instance);

  test('network test', () async {
    final response = await service.searchByName("intibah");
    expect(response, isNotNull);
  });

  test(
    "item count should be 10",
    () async {
      final response = await service.searchByName("intibah");
      expect(response?.items?.length, 10);
    },
  );
}
