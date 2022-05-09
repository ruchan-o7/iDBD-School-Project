import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/feature/publisher_view/add_book_view/model.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import '../../../../product/publisher_user_model/publisher_user.dart';

part 'deletereq_state.dart';

class DeletereqCubit extends Cubit<DeletereqState> {
  DeletereqCubit(this.currentUser) : super(DeletereqInitial()) {
    getBooks();
  }

  final PublisherUser? currentUser;
  PublisherUser? _publisherUser;
  final List<BookRequestModel?>? books = [];
  final FirestoreFunctions _functions = FirestoreFunctions();
  getBooks() async {
    _publisherUser = await _functions.getPublisherUser(currentUser?.userId);
    emit(LoadingState());
    for (var item in currentUser?.onGoingRequests ?? []) {
      books?.add(await _functions.getBookByIdRequested(item));
    }
    emit(DataFetched());
  }

  Future<void> deleteReq(String id, int index) async {
    await _functions.removeReq(id, currentUser?.userId);
    books?.removeAt(index);
  }
}
