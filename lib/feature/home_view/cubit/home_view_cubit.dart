import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../book_detail/book_detail_view.dart';
import '../../../product/utils/firebase/firestore_func.dart';

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
  final FirestoreFunctions _functions = FirestoreFunctions();
  final ScrollController scrollController = ScrollController();

  IsLoading loadState = IsLoading.no;
  BookResponseModel? categorieBooks;
  BookResponseModel? recommendedBooks;

  bool isUserPublisher = false;

  Future<void> checkUserIsPublisher() async {
    isUserPublisher = await _functions.checkUserPublisher(FirebaseAuth.instance.currentUser?.uid);
  }

  logOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginCardView(),
    ));
  }

  init() async {
    await _auth.initializeFirebase();
    checkUserIsPublisher();
    getRecommendedBooks();
    getBooksFromCategories(Categories.instance.getCategorieList?.first ?? "History");
  }

  goToPage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

  getRecommendedBooks() async {
    final _cateData = sortCategories(await _functions.getStatistics());
    if (_cateData?.keys.first != null) {
      recommendedBooks = await _service.randomSearchWithCategories(_cateData?.keys.first ?? "");
    }
    emit(BooksLoaded());
  }

  Map<String, int>? sortCategories(Map<String, int> map) {
    var _sortedEntries = map.entries.toList()
      ..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) {
          diff = e2.key.compareTo(e1.key);
        }
        return diff;
      });
    Map<String, int> _temp = {};
    for (var item in _sortedEntries) {
      _temp[item.key] = item.value;
    }
    return _temp;
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
