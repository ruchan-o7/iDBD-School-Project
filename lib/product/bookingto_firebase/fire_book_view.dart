import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../base_model/book_response_mode.dart';
import '../utils/firebase/firestore_func.dart';

class FireBookView extends StatefulWidget {
  const FireBookView({Key? key}) : super(key: key);

  @override
  State<FireBookView> createState() => _FireBookViewState();
}

class _FireBookViewState extends State<FireBookView> {
  BookResponseModel? model;

  Future<void> getBooks() async {
    final dio = Dio();
    final response = await dio.get("https://www.googleapis.com/books/v1/volumes?q=kumarbaz");
    if (response.statusCode == 200) {
      model = BookResponseModel.fromJson(response.data);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  FirestoreFunctions funcs = FirestoreFunctions();
  void saveBooks() {
    if (model != null) {
      model?.items?.forEach((element) {
        if (element.volumeInfo?.categories != null && element.volumeInfo?.title != null) {
          funcs.addBook(element);
        }
      });
    } else {}
  }

  void clearRam() {
    model = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getBooks,
            child: const Icon(Icons.download),
          ),
          FloatingActionButton(
            onPressed: saveBooks,
            child: const Icon(Icons.upload),
          ),
          FloatingActionButton(
            onPressed: clearRam,
            child: const Icon(Icons.clear_all),
          )
        ],
      ),
    );
  }
}
