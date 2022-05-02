import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/book_detail/book_detail_view.dart';

import '../../../core/network/network_manager.dart';
import '../../../product/base_model/book_response_mode.dart';
import '../../../product/book_categories/categories.dart';
import '../../../product/utils/firebase/firebase_auth.dart';
import '../../login_screen/view/login_card_view.dart';
import '../../search_view/service/search_book_service.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(HomeViewInitial()) {
    init();
  }

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final Authentication _auth = Authentication();
  final ISearchBookService _service = SearchBookService(NetworkManager.instance);
  BookResponseModel? categorieBooks;

  IsLoading loadState = IsLoading.no;

  logOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginCardView(),
    ));
  }

  init() async {
    await _auth.initializeFirebase();
    getBooksFromCategories(Categories.instance.getCategorieList?.first ?? "History");
  }

  goToPage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

  getBooksFromCategories(String categorie) async {
    if (categorieBooks == null) {
      loadState = IsLoading.yes;
      emit(BooksUnloaded());
      categorieBooks = await _service.randomSearchWithCategories(categorie);
      loadState = IsLoading.no;
      emit(BooksLoaded());
    } else {
      loadState = IsLoading.yes;
      emit(BooksUnloaded());
      categorieBooks = null;
      categorieBooks = await _service.randomSearchWithCategories(categorie);
      loadState = IsLoading.no;
      emit(BooksLoaded());
    }
  }

  void goToBook(BuildContext context, Items? bookModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetail(bookModel: bookModel),
        ));
  }
}

enum IsLoading { yes, no }
