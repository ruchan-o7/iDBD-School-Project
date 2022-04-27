import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/logo_path.dart';
import 'package:school_project_ibdb/core/constants/string_constants.dart';
import 'package:school_project_ibdb/product/circle_avatar/custom_circle_avatar.dart';
import 'package:school_project_ibdb/product/comment_model/comment_model.dart';

import '../../product/base_model/book_response_mode.dart';
import 'cubit/bookdetail_cubit.dart';

class BookDetail extends StatelessWidget {
  BookDetail({Key? key, this.bookModel, required this.isComeFromProfile}) : super(key: key);

  Items? bookModel;
  bool isComeFromProfile;
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailCubit(bookModel: bookModel),
      child: BlocConsumer<BookDetailCubit, BookDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(),
            body: body(context),
            floatingActionButton: FAB(context),
          );
        },
      ),
    );
  }

  Column FAB(BuildContext context) {
    Future<void> writeComment() async {
      if (commentController.text != "" && commentController.text != null) {
        await context.read<BookDetailCubit>().writeComment(commentController.text);
        commentController.clear();
      }
    }

    List<commentModelFromRTD>? _comments = context.read<BookDetailCubit>().comments;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
              heroTag: null,
              tooltip: "Like",
              onPressed: () {},
              child: const Icon(
                Icons.thumb_up,
              )),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
              heroTag: null,
              tooltip: "comment",
              onPressed: () {
                showModalBottomSheet(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: context.dynamicHeight(0.01),
                              ),
                              _comments == null && _comments?.length == 0
                                  ? Text("No comments here")
                                  : SizedBox(
                                      height: context.dynamicHeight(0.45),
                                      child: ListView.builder(
                                        itemCount: _comments?.length,
                                        itemBuilder: (context, index) => ListTile(
                                          leading: CustomCircleAvatar(
                                              size: 10,
                                              avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
                                          title: Text(_comments?[index].comment ?? "null comment"),
                                        ),
                                      ),
                                    ),
                              Divider(
                                thickness: 2,
                                indent: context.dynamicWidth(0.1),
                                endIndent: context.dynamicWidth(0.1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomCircleAvatar(
                                avatarUrl: FirebaseAuth.instance.currentUser?.photoURL,
                                size: context.dynamicWidth(0.05),
                              ),
                              SizedBox(
                                width: context.dynamicWidth(0.05),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: commentController,
                                onSubmitted: (v) async => await writeComment(),
                              )),
                            ],
                          ),
                        ],
                      );
                    });
              },
              child: const Icon(Icons.add_comment)),
        ),
      ],
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: context.dynamicHeight(0.4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: bookModel?.volumeInfo?.imageLinks?.thumbnail == null
                    ? Container(
                        constraints: BoxConstraints(minHeight: context.dynamicHeight(0.3)),
                        child: Image.asset(LogoPaths.dummyBook),
                      )
                    : Image.network(bookModel?.volumeInfo?.imageLinks?.thumbnail ?? "", fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          Text(bookModel?.volumeInfo?.title ?? StringConstants().notFound),
          Text(bookModel?.volumeInfo?.authors?.first ?? StringConstants().notFound,
              style: Theme.of(context).textTheme.bodyText1),
          Row(
            children: [
              Text(bookModel?.volumeInfo?.ratingsCount?.toString() ?? ""),
              if (bookModel?.volumeInfo?.ratingsCount != null &&
                  bookModel?.volumeInfo?.ratingsCount.toString() != "")
                const Icon(Icons.star)
            ],
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Page number:"),
                  bookModel?.volumeInfo?.language != null ? Text("Language:") : SizedBox(),
                  bookModel?.volumeInfo?.publishedDate != null ? Text("Publish Date:") : SizedBox(),
                ],
              ),
              Column(
                children: [
                  Text(bookModel?.volumeInfo?.pageCount?.toString() ?? "Unknown"),
                  Text(bookModel?.volumeInfo?.language ?? ""),
                  Text(bookModel?.volumeInfo?.publishedDate ?? "")
                ],
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: context.horizontalPaddingNormal,
            child: Text(bookModel?.volumeInfo?.description?.toString() ?? StringConstants().notFound,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          // context.read<BookDetailCubit>().comments == null
          //     ? SizedBox(
          //         height: context.dynamicHeight(0.8),
          //         child: ListView.separated(
          //             itemBuilder: (context, index) => ListTile(
          //                   leading: Image.asset(LogoPaths.dummyPer),
          //                   // title: Text(
          //                   //     context.read<BookDetailCubit>().allComments?.comments?[index].commentOwner ??
          //                   //         "asd"),
          //                   title: Text(
          //                     """context
          //                                   .read<BookDetailCubit>()
          //                                   .allComments
          //                                   ?.comments?[index]
          //                                   ?.commentOwner""",
          //                     style: Theme.of(context).textTheme.bodyMedium,
          //                   ),
          //                   subtitle: Text("""context
          //                                 .read<BookDetailCubit>()
          //                                 .allComments
          //                                 ?.comments?[index]
          //                                 ?.comment"""),
          //                   trailing: Text(
          //                     """context
          //                                   .read<BookDetailCubit>()
          //                                   .allComments
          //                                   ?.comments?[index]
          //                                   ?.commentTime
          //                                   ?.substring(0, 19)
          //                                   .replaceAll("T", " ")""",
          //                     style: Theme.of(context).textTheme.bodySmall,
          //                   ),
          //                 ),
          //             separatorBuilder: (_, index) => const Divider(thickness: 1),
          //             itemCount:
          //                 //  context.read<BookDetailCubit>().allComments?.comments?.length ?? 0
          //                 2),
          //       )
          //     : Column(
          //         children: [
          //           const Divider(),
          //           // const Text("There is no comment. Write first comment here"),
          //         ],
          //       )
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(elevation: 0);
}
