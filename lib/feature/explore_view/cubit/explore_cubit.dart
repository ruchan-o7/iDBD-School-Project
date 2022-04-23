import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/core/network/NetworkManager.dart';
import 'package:school_project_ibdb/feature/search_view/model/searched_book_model.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial()) {
    initBooks();
  }
  final ISearchBookService _service = SearchBookService(NetworkManager.instance);
  SearchBookModel? exploreBooks;
  Future<void> initBooks() async {
    emit(BooksDownloading());
    exploreBooks = await _service.searchRandom();
    emit(BooksDownloaded());
  }
}
