import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/core/network/NetworkManager.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import 'model/searched_book_model.dart';

class SearchViewCubit extends Cubit<SearchViewState> {
  SearchViewCubit() : super(SearchViewInitial());
  final searchController = TextEditingController();
  final searchNode = FocusNode();

  SearchBookModel? results;
  ISearchBookService _service = SearchBookService(NetworkManager.instance);
  List<Items>? searchedBookFromDatabase;

  FirestoreFunctions _functions = FirestoreFunctions();

  Future<void> searchBooks(String searchText) async {
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
}

abstract class SearchViewState {}

class SearchViewInitial extends SearchViewState {}

class SearchingState extends SearchViewState {}

class SearchDone extends SearchViewState {}
