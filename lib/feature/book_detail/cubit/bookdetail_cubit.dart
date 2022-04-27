import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import '../../../product/base_model/book_response_mode.dart';
import '../../../product/comment_model/comment_model.dart';

part 'bookdetail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit({this.bookModel}) : super(BookdetailInitial()) {
    getComments();
  }

  bool isClicked = false;
  Items? bookModel;
  FirestoreFunctions firestoreFunctions = FirestoreFunctions();
  List<commentModelFromRTD>? comments;

  void changeClicked() {
    isClicked = !isClicked;
    emit(ClickedToButton());
  }

  Future<void> getComments() async {
    comments = await firestoreFunctions.readCommentData(bookModel?.id);
    if (comments != null) emit(CommentLoaded());
  }

  Future<void> writeComment(String text) async {
    await firestoreFunctions.writeCommentData(bookModel?.id ?? "0", FirebaseAuth.instance.currentUser, text);
    getComments();
  }

  void likeBook() async {
    firestoreFunctions.likeBook(bookModel, FirebaseAuth.instance.currentUser);
  }
}
