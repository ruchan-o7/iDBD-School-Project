import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/network_manager.dart';
import '../book_detail/book_detail_view.dart';
import 'service/search_book_service.dart';
import '../../product/base_model/book_response_mode.dart';
import '../../product/utils/firebase/firestore_func.dart';

import 'model/searched_book_model.dart';

class SearchViewCubit extends Cubit<SearchViewState> {
  SearchViewCubit() : super(SearchViewInitial());
  final searchController = TextEditingController();
  final searchNode = FocusNode();

  SearchBookModel? results;
  final ISearchBookService _service = SearchBookService(NetworkManager.instance);
  List<Items>? searchedBookFromDatabase;
  String? path;

  final FirestoreFunctions _functions = FirestoreFunctions();
  final GenerateRandomProfilePic _picGenerate = GenerateRandomProfilePic();
  Future<void> callFunc() async {
    path = await _picGenerate.generateRandomPic();
  }

  Future<void> searchBooks(String? searchText) async {
    emit(SearchingState());
    if (searchText != null && searchText != "") {
      searchNode.unfocus();
      await searchFromDatabase(searchText);
      results = await _service.searchByName(searchText);
      emit(SearchDone());
    }
  }

  searchFromDatabase(String searchText) async {
    searchedBookFromDatabase = await _functions.searchBookFromName(searchText);
  }

  goToBook(Items? model, BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BookDetail(bookModel: model),
    ));
  }
}

abstract class SearchViewState {}

class SearchViewInitial extends SearchViewState {}

class SearchingState extends SearchViewState {}

class SearchDone extends SearchViewState {}
