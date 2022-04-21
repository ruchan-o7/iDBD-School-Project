import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../base_model/book_response_mode.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.bookModel}) : super(key: key);

  Items? bookModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: context.dynamicHeight(0.015)),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  bookModel?.volumeInfo?.imageLinks?.thumbnail ?? "null",
                  fit: BoxFit.contain,
                  scale: 1.2,
                ),
              ),
            ),
            // SizedBox(height: context.dynamicHeight(0.015)),
            Text(bookModel?.volumeInfo?.title ?? "null title"),
            SizedBox(
              height: context.dynamicHeight(0.015),
              child: ListView.builder(
                itemBuilder: (context, index) => Text(bookModel?.volumeInfo?.authors?[index] ?? "null author",
                    style: Theme.of(context).textTheme.bodySmall),
                itemCount: bookModel?.volumeInfo?.authors?.length,
              ),
            )
            // Text(
            //   "Yazar",
            //   style: Theme.of(context).textTheme.bodySmall,
            // )
          ],
        ),
      ),
    );
    // return Card(
    //     child: Column(
    //   children: [
    //     Image.network(
    //       bookModel?.volumeInfo?.imageLinks?.thumbnail ?? "",
    //       fit: BoxFit.fitWidth,
    //     ),
    //     Container(
    //         decoration: const BoxDecoration(
    //       gradient: LinearGradient(
    //           colors: [
    //             Colors.black,
    //             Colors.transparent,
    //           ],
    //           begin: Alignment.bottomCenter,
    //           end: Alignment.topCenter,
    //           stops: [0, 0.4]),
    //     )),
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         Text(bookModel?.volumeInfo?.title ?? "null title",
    //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black)),
    //       ],
    //     )
    //   ],
    // ));
  }
}
