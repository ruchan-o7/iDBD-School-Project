import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../base_model/book_response_mode.dart';
import '../utils/firebase/firestore_func.dart';

class FireBookView extends StatefulWidget {
  FireBookView({Key? key}) : super(key: key);

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
      log(model.toString());
      log(model?.items?.first.volumeInfo?.title ?? "null title");
      log(model?.items?.first.volumeInfo?.authors?.first ?? "null authors");
      log(model?.items?.first.id ?? "null id");
      log(model?.items?.first.volumeInfo?.pageCount.toString() ?? "null pageCount");
      log(model?.items?.first.volumeInfo?.pageCount.toString() ?? "null title");
      log(model?.items?.first.volumeInfo?.categories?.first.toString() ?? "null title");
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
    } else {
      log("model boş");
    }
  }

  void clearRam() {
    model = null;
    log("model silindi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getBooks,
            child: Icon(Icons.download),
          ),
          FloatingActionButton(
            onPressed: saveBooks,
            child: Icon(Icons.upload),
          ),
          FloatingActionButton(
            onPressed: clearRam,
            child: Icon(Icons.clear_all),
          )
        ],
      ),
    );
  }
}
