import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../sign_up/model/signup_model.dart';
import '../../../product/utils/firebase/firestore_func.dart';

import '../../../product/base_model/book_response_mode.dart';
import '../../../product/comment_model/comment_model.dart';

part 'bookdetail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit({this.bookModel}) : super(BookdetailInitial()) {
    getComments();
    checkBookLiked();
  }

  Items? bookModel;
  final FirestoreFunctions _firestoreFunctions = FirestoreFunctions();
  List<CommentModelFromRTD>? comments;
  List<UserSignUpModel>? commenters = [];
  final scaffoldState = GlobalKey<ScaffoldState>();
  final bottomSheetController = DraggableScrollableController();
  final draggableScrollBont = ScrollController();
  bool isUpVoted = false;
  bool isDownVoted = false;
  bool isVoted = false;
  bool isBookLiked = false;
  bool? isUpArrow;

  Future<void> checkBookLiked() async {
    final _temp = await _firestoreFunctions.getUser(FirebaseAuth.instance.currentUser?.uid);
    if (_temp?.likedBooks != null) {
      for (String item in _temp!.likedBooks ?? []) {
        if (item == bookModel?.id) {
          isBookLiked = true;
          emit(ClickedToButton());
          return;
        } else {
          isBookLiked = false;
        }
      }
    }
  }

  Future<void> getComments() async {
    comments = await _firestoreFunctions.readCommentData(bookModel?.id);

    if (comments != null) {
      for (CommentModelFromRTD item in comments!) {
        commenters?.add(await getUserPhoto(item.commenterId));
      }
      emit(CommentLoaded());
    }
  }

  getUserPhoto(String? uid) async {
    UserSignUpModel? model;
    model = await _firestoreFunctions.getUser(uid);
    return model;
  }

  Future writeComment(String text, BuildContext context, Items? book) async {
    if (book?.id == null) {
      Navigator.pop(context);
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fail")));
    } else {
      await _firestoreFunctions.writeCommentData(book?.id, FirebaseAuth.instance.currentUser, text);
      getComments();
      emit(CommentLoaded());
    }
  }

  void likeBook() async {
    await _firestoreFunctions.likeBook(bookModel, FirebaseAuth.instance.currentUser);
    isBookLiked = true;
    await _firestoreFunctions.writeCategoriesData(bookModel, FirebaseAuth.instance.currentUser);
    emit(ClickedToButton());
  }

  Future<void> unLikeBook() async {
    final _temp = await _firestoreFunctions.getUser(FirebaseAuth.instance.currentUser?.uid);
    // ignore: prefer_is_empty
    if (_temp?.likedBooks != null && _temp?.likedBooks?.length != 0) {
      _firestoreFunctions.unLikeBook(bookModel, FirebaseAuth.instance.currentUser);
      isBookLiked = false;
      emit(ClickedToButton());
    }
  }

  clearVotes() {
    isUpVoted = false;
    isDownVoted = false;
    isVoted = false;
  }

  Future<void> giveVote(bool isUpward, String? bookId) async {
    if (bookId == null) return;
    if (isVoted == false) {
      if (isUpward) {
        isUpVoted = true;
        isDownVoted = false;
        emit(ClickedToButton());
        await _firestoreFunctions.giveVote(bookId, true, isVoted);
        isVoted = true;
      } else {
        isUpVoted = false;
        isDownVoted = true;
        emit(ClickedToButton());
        await _firestoreFunctions.giveVote(bookId, false, isVoted);
        isVoted = true;
      }

      // giveColor(isUpward);
      // await _firestoreFunctions.giveVote(bookId, isUpward, false);
    } else {
      clearVotes();
      emit(ClickedToButton());
      await _firestoreFunctions.giveVote(bookId, isUpward, true);
    }
  }
}
