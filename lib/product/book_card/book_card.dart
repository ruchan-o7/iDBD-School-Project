import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../core/constants/logo_path.dart';

import '../../feature/book_detail/book_detail_view.dart';
import '../base_model/book_response_mode.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.bookModel, required this.isComeFromProfile}) : super(key: key);

  Items? bookModel;
  bool isComeFromProfile;

  bool validatePhoto(String? avatarUrl) {
    if (avatarUrl == null) {
      return false;
    } else if (avatarUrl == "") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return itemModel(context);
  }

  Widget itemModel(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetail(bookModel: bookModel, isComeFromProfile: isComeFromProfile),
              ));
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
                        image: validatePhoto(bookModel?.volumeInfo?.imageLinks?.thumbnail)
                            ? NetworkImage("${bookModel?.volumeInfo?.imageLinks?.thumbnail}")
                            : const AssetImage(LogoPaths.dummyBook) as ImageProvider,
                        fit: BoxFit.contain),
                  ),
                  child: bookModel?.volumeInfo?.imageLinks?.thumbnail == null
                      ? Image.asset(LogoPaths.dummyBook)
                      : null),
              Divider(),
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
    );
  }
}
