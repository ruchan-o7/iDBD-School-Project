import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/feature/publisher_view/add_book_view/model.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import '../../../../product/publisher_user_model/publisher_user.dart';

part 'publisherreports_state.dart';

class PublisherReportsCubit extends Cubit<PublisherReportsState> {
  PublisherReportsCubit({required this.currentUser}) : super(PublisherReportsInitial()) {
    getPublisherProfile();
  }

  final PublisherUser? currentUser;

  final List<BookRequestModel>? books = [];
  final FirestoreFunctions _functions = FirestoreFunctions();
  Future<void> getPublisherProfile() async {
    for (var item in currentUser?.onGoingRequests ?? []) {
      books?.add(await getRequestedBooks(item));
    }
    emit(DataFetched());
  }

  getRequestedBooks(String bookId) async {
    return await _functions.getBookByIdRequested(bookId);
  }
}
