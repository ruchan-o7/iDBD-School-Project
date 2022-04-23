import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/logo_path.dart';

import '../../feature/book_detail/book_detail_view.dart';
import '../base_model/book_response_mode.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.bookModel}) : super(key: key);

  Items? bookModel;
  @override
  Widget build(BuildContext context) {
    return itemModel(context);
  }

  InkWell itemModel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetail(bookModel: bookModel),
            ));
      },
      child: Card(
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: context.dynamicHeight(0.155),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(bookModel?.volumeInfo?.imageLinks?.thumbnail != null
                          ? "${bookModel?.volumeInfo?.imageLinks?.thumbnail}"
                          : LogoPaths.dummyBook),
                      fit: BoxFit.contain),
                ),
              ),
              Divider(),
              Text(
                bookModel?.volumeInfo?.title ?? "null title",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: context.dynamicHeight(0.015),
                child: ListView.builder(
                  itemBuilder: (context, index) => Text(
                      bookModel?.volumeInfo?.authors?[index] ?? "null author",
                      style: Theme.of(context).textTheme.bodySmall),
                  itemCount: bookModel?.volumeInfo?.authors?.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
