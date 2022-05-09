import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/feature/publisher_view/add_book_view/model.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

part 'publisherreports_state.dart';

class PublisherReportsCubit extends Cubit<PublisherReportsState> {
  PublisherReportsCubit() : super(PublisherReportsInitial()) {
    getPublisherProfile();
  }

  final List<BookRequestModel>? books = [];
  final FirestoreFunctions _functions = FirestoreFunctions();
  Future<void> getPublisherProfile() async {
    final _temp = await _functions.getBookByIdPublisherRequest(FirebaseAuth.instance.currentUser?.uid ?? "");

    for (var item in _temp?.onGoingRequests ?? []) {
      books?.add(await getRequestedBooks(item));
    }
    emit(DataFetched());
  }

  getRequestedBooks(String bookId) async {
    return await _functions.getBookByIdRequested(bookId);
  }
}
