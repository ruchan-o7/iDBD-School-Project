import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project_ibdb/core/network/NetworkManager.dart';
import 'package:school_project_ibdb/feature/blankview/service/search_book_service.dart';

void main(List<String> args) {
  ISearchBookService service = SearchBookService(NetworkManager.instance);

  setUp(() async {});
  test('network test', () async {
    final response = await service.searchByName(
        "https://www.googleapis.com/books/v1/volumes?q=intibah:keyes&key=AIzaSyBLexVuCT5dQxJY8tMz9hleQ3st5w4nstY");
    expect(response, isNotNull);
  });
}
//https://www.googleapis.com/books/v1/volumes?q=intibah:keyes&key=AIzaSyBLexVuCT5dQxJY8tMz9hleQ3st5w4nstY