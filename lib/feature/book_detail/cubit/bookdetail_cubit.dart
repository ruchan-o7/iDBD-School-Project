import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/product/comment_model/comment_model.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import '../../../product/base_model/book_response_mode.dart';

part 'bookdetail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit({this.bookModel}) : super(BookdetailInitial()) {
    getComments();
  }

  bool isClicked = false;
  Items? bookModel;
  FirestoreFunctions firestoreFunctions = FirestoreFunctions();
  CommentModel? allComments;

  void changeClicked() {
    isClicked = !isClicked;
    emit(ClickedToButton());
  }

  Future<void> getComments() async {
    allComments = await firestoreFunctions.readCommentData(bookModel?.id);
    if (allComments != null) emit(CommentLoaded());
  }

  void writeComment(String text) {
    firestoreFunctions.writeCommentData(
      CommentModel(
        id: bookModel?.id,
        rating: bookModel?.volumeInfo?.ratingsCount.toString(),
        comments: [
          Comment(
            comment: text,
            commentOwner: FirebaseAuth.instance.currentUser?.displayName,
            commentTime: DateTime.now().toIso8601String().substring(0, 19),
          )
        ],
      ),
    );
    getComments();
  }
}
