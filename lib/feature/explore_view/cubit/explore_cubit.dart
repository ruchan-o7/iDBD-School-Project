import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/network/NetworkManager.dart';
import '../../search_view/model/searched_book_model.dart';
import '../../search_view/service/search_book_service.dart';
import '../../../product/base_model/book_response_mode.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial()) {
    initBooks();
  }
  final ISearchBookService _service = SearchBookService(NetworkManager.instance);
  SearchBookModel? exploreBooks;
  BookResponseModel? model;
  Future<void> initBooks() async {
    emit(BooksDownloading());
    exploreBooks = await _service.searchRandom();
    emit(BooksDownloaded());
  }
}
