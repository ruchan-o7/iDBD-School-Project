import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/logo_path.dart';
import '../../feature/book_detail/book_detail_view.dart';
import '../base_model/book_response_mode.dart';
import '../neumorphic_container/custom_container.dart';
import '../utils/validator/validator.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.bookModel}) : super(key: key);

  Items? bookModel;

  @override
  Widget build(BuildContext context) {
    return itemModel(context);
  }

  Widget itemModel(BuildContext context) {
    return NeumCont(
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BookDetail(bookModel: bookModel)));
          },
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
                          image: Validator().validateString(bookModel?.volumeInfo?.imageLinks?.thumbnail)
                              ? NetworkImage("${bookModel?.volumeInfo?.imageLinks?.thumbnail}")
                              : const AssetImage(LogoPaths.dummyBook) as ImageProvider,
                          fit: BoxFit.contain),
                    ),
                    child: bookModel?.volumeInfo?.imageLinks?.thumbnail == null
                        ? Image.asset(LogoPaths.dummyBook)
                        : null),
                const Divider(),
                Container(
                  constraints: BoxConstraints(maxHeight: context.dynamicHeight(0.08)),
                  child: Text(
                    bookModel?.volumeInfo?.title ?? "null title",
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.015),
                  child: ListView.builder(
                    itemBuilder: (context, index) => Text(
                      bookModel?.volumeInfo?.authors?[index] ?? "null author",
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                    ),
                    itemCount: bookModel?.volumeInfo?.authors?.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
