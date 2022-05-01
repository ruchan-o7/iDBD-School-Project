import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../../core/constants/logo_path.dart';
import '../../core/constants/string_constants.dart';
import '../sign_up/model/signup_model.dart';
import '../../product/comment_model/comment_model.dart';

import '../../core/custom/custom_divider.dart';
import '../../product/base_model/book_response_mode.dart';
import '../../product/circle_avatar/custom_circle_avatar.dart';
import 'cubit/bookdetail_cubit.dart';

class BookDetail extends StatelessWidget {
  BookDetail({Key? key, this.bookModel}) : super(key: key);

  Items? bookModel;
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailCubit(bookModel: bookModel),
      child: BlocConsumer<BookDetailCubit, BookDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: context.read<BookDetailCubit>().scaffoldState,
            appBar: appBar(),
            body: body(context),
            floatingActionButton: FAB(context),
          );
        },
      ),
    );
  }

  Column FAB(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
              heroTag: null,
              tooltip: "Like",
              onPressed: () {
                if (context.read<BookDetailCubit>().isBookLiked == true) {
                  context.read<BookDetailCubit>().unLikeBook();
                } else {
                  context.read<BookDetailCubit>().likeBook();
                }
              },
              child: Icon(
                Icons.thumb_up,
                color: context.read<BookDetailCubit>().isBookLiked ? Colors.red : Colors.black,
              )),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
              heroTag: null,
              tooltip: "comment",
              onPressed: () {
                context.read<BookDetailCubit>().getComments();
                final _commenters = context.read<BookDetailCubit>().commenters;
                final _comments = context.read<BookDetailCubit>().comments;
                final _book = context.read<BookDetailCubit>().bookModel;

                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => BookDetailCubit(),
                    child: BlocConsumer<BookDetailCubit, BookDetailState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return buildSheet(_book, context, _commenters, _comments);
                      },
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add_comment)),
        ),
      ],
    );
  }

  Widget buildSheet(
    Items? book,
    BuildContext context,
    List<UserSignUpModel>? commenters,
    List<commentModelFromRTD>? comments,
  ) {
    return DraggableScrollableSheet(
        initialChildSize: 0.62,
        maxChildSize: 0.9,
        expand: false,
        minChildSize: 0.5,
        controller: context.read<BookDetailCubit>().bottomSheetController,
        builder: (context, controller) {
          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: context.dynamicHeight(0.02)),
                    CustomDivider(context: context),
                    SizedBox(
                      height: context.dynamicHeight(0.42),
                      // ignore: prefer_is_empty
                      child: comments == null || comments.length == 0
                          ? const Center(child: Text("No comments yet"))
                          : ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CustomCircleAvatar(
                                    size: 10,
                                    avatarUrl: commenters?[index].imageUrl,
                                  ),
                                  title: Text(
                                      "${commenters?[index].userName ?? "null username"} : ${comments[index].comment ?? "null comment"}"),
                                );
                              }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomDivider(context: context),
                    Padding(
                      padding: context.paddingLow,
                      child: Row(
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              gapPadding: 20,
                            )),
                            controller: commentController,
                            onSubmitted: (v) {
                              context.read<BookDetailCubit>().writeComment(v, context, book);
                              commentController.clear();
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
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
            mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(elevation: 0);
}
