import 'package:flutter/material.dart';

import '../base_model/book_response_mode.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.bookModel}) : super(key: key);

  Items bookModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            bookModel.volumeInfo?.imageLinks?.thumbnail ?? "",
            fit: BoxFit.fitWidth,
          ),
          Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 0.4]),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(bookModel.volumeInfo?.title ?? "null title",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
