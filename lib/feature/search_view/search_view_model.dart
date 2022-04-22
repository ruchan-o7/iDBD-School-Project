import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/core/network/NetworkManager.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';

import 'model/searched_book_model.dart';

class SearchViewCubit extends Cubit<SearchViewState> {
  SearchViewCubit() : super(SearchViewInitial());
  final searchController = TextEditingController();
  final searchNode = FocusNode();

  SearchBookModel? results;
  ISearchBookService _service = SearchBookService(NetworkManager.instance);

  Future<void> searchBooks(String searchText) async {
    emit(SearchingState());
    if (searchText != null && searchText != "") {
      searchNode.unfocus();
      results = await _service.searchByName(searchText);
      emit(SearchDone());
    }
  }
}

abstract class SearchViewState {}

class SearchViewInitial extends SearchViewState {}

class SearchingState extends SearchViewState {}

class SearchDone extends SearchViewState {}
