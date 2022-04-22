import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../product/base_model/book_response_mode.dart';

class BookDetail extends StatelessWidget {
  BookDetail({Key? key, this.bookModel}) : super(key: key);
  Items? bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(bookModel?.volumeInfo?.imageLinks?.thumbnail ?? ""),
            ),
            Text(
              bookModel?.volumeInfo?.title ?? "null title",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Text(bookModel?.volumeInfo?.authors?.first ?? "null author info",
                style: Theme.of(context).textTheme.bodyLarge),
            Divider(),
            Row(
              children: [
                Text(bookModel?.volumeInfo?.ratingsCount?.toString() ?? ""),
                if (bookModel?.volumeInfo?.ratingsCount != null) Icon(Icons.star)
              ],
            ),
            Text("About Book"),
            Text(bookModel?.volumeInfo?.description.toString() == "null"
                ? "We couldn't any information about this book"
                : bookModel?.volumeInfo?.description.toString() ??
                    "We couldn't any information about this book"),
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          ///Gonna add saved books funcs
                        },
                        child: Text("Save This Book"))),
                VerticalDivider(),
                Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Buraya ne yazılacak aq")))
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            )
          ],
        ));
  }
}
