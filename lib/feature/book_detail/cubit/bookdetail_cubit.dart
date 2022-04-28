import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/sign_up/model/signup_model.dart';
import 'package:school_project_ibdb/product/circle_avatar/custom_circle_avatar.dart';
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
  final FirestoreFunctions _firestoreFunctions = FirestoreFunctions();
  List<commentModelFromRTD>? comments;
  List<UserSignUpModel>? commenters = [];
  final scaffoldState = GlobalKey<ScaffoldState>();

  void changeClicked() {
    isClicked = !isClicked;
    emit(ClickedToButton());
  }

  Future<void> getComments() async {
    comments = await _firestoreFunctions.readCommentData(bookModel?.id);

    if (comments != null) {
      for (commentModelFromRTD item in comments!) {
        commenters?.add(await getUserPhoto(item.commenterId));
      }
    }
  }

  getUserPhoto(String? uid) async {
    UserSignUpModel? model;
    model = await _firestoreFunctions.getUser(uid);
    return model;
  }

  Future<void> writeComment(String text) async {
    await _firestoreFunctions.writeCommentData(bookModel?.id ?? "0", FirebaseAuth.instance.currentUser, text);
    getComments();
  }

  void likeBook() async {
    _firestoreFunctions.likeBook(bookModel, FirebaseAuth.instance.currentUser);
  }
}
