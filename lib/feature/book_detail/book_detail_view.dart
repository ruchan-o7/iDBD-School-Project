import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/product/utils/validator/validator.dart';
import '../../core/constants/border_radius.dart';
import '../../core/constants/logo_path.dart';
import '../../core/constants/string_constants.dart';
import '../sign_up/model/signup_model.dart';
import '../../product/comment_model/comment_model.dart';
import '../../core/custom/custom_divider.dart';
import '../../product/base_model/book_response_mode.dart';
import '../../product/circle_avatar/custom_circle_avatar.dart';
import 'cubit/bookdetail_cubit.dart';

class BookDetail extends StatelessWidget {
  BookDetail({Key? key, required this.bookModel}) : super(key: key);

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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: context.dynamicHeight(0.03))),
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  expandedHeight: context.dynamicHeight(0.4),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    expandedTitleScale: 20,
                    background: Validator().validateString(bookModel?.volumeInfo?.imageLinks?.thumbnail)
                        ? Image.network(
                            bookModel?.volumeInfo?.imageLinks?.thumbnail ?? "",
                            fit: BoxFit.fitHeight,
                          )
                        : Image.asset(LogoPaths.dummyBook),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Text(
                          bookModel?.volumeInfo?.title ?? "null title",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(bookModel?.volumeInfo?.authors?.first ?? "null title",
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(bookModel?.volumeInfo?.title ?? "null title"),
                        Text(bookModel?.volumeInfo?.title ?? "null title"),
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
                                bookModel?.volumeInfo?.pageCount != null
                                    ? const Text("Page number:")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.language != null
                                    ? const Text("Language:")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.publishedDate != null
                                    ? const Text("Publish Date:")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.categories?.first != null
                                    ? const Text("Categories")
                                    : const SizedBox()
                              ],
                            ),
                            Column(
                              children: [
                                bookModel?.volumeInfo?.pageCount != null
                                    ? Text(bookModel?.volumeInfo?.pageCount?.toString() ?? "Unknown")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.language != null
                                    ? Text(bookModel?.volumeInfo?.language ?? "")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.publishedDate != null
                                    ? Text(bookModel?.volumeInfo?.publishedDate ?? "")
                                    : const SizedBox(),
                                bookModel?.volumeInfo?.categories != null
                                    ? Text(bookModel?.volumeInfo?.categories?.first ?? "null")
                                    : const SizedBox()
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: context.horizontalPaddingNormal,
                          child: Text(
                              "  " +
                                  (bookModel?.volumeInfo?.description?.toString() ??
                                      StringConstants().notFound),
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            ),
            floatingActionButton: fab(context),
          );
        },
      ),
    );
  }

  Widget fab(BuildContext context) {
    bool _isLiked = context.read<BookDetailCubit>().isBookLiked;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
            heroTag: null,
            tooltip: "Up vote",
            backgroundColor:
                context.read<BookDetailCubit>().isDownVoted ? Colors.grey : Theme.of(context).primaryColor,
            onPressed: context.read<BookDetailCubit>().isDownVoted
                ? null
                : () {
                    if (context.read<BookDetailCubit>().isBookLiked) {
                      context.read<BookDetailCubit>().giveVote(true, bookModel?.id);
                    }
                  },
            child: Icon(
              Icons.arrow_upward,
              color: context.read<BookDetailCubit>().isUpVoted ? Colors.red : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: Text(context.read<BookDetailCubit>().votes?["up"].toString() ?? "0"),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor:
                context.read<BookDetailCubit>().isUpVoted ? Colors.grey : Theme.of(context).primaryColor,
            tooltip: "Down vote",
            onPressed: context.read<BookDetailCubit>().isUpVoted
                ? null
                : () {
                    if (context.read<BookDetailCubit>().isBookLiked) {
                      context.read<BookDetailCubit>().giveVote(false, bookModel?.id);
                    }
                  },
            child: Icon(Icons.arrow_downward,
                color: context.read<BookDetailCubit>().isDownVoted ? Colors.red : Colors.black),
          ),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: Text(context.read<BookDetailCubit>().votes?["down"].toString() ?? "0"),
        ),
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
                color: _isLiked ? Colors.red : Colors.black,
              )),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: FloatingActionButton(
              heroTag: null,
              tooltip: "comment",
              onPressed: () {
                context.read<BookDetailCubit>().getComments(bookModel?.id ?? "");
                // final _commenters = context.read<BookDetailCubit>().commenters;
                // final _comments = context.read<BookDetailCubit>().comments;
                final _book = context.read<BookDetailCubit>().bookModel;

                showModalBottomSheet(
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => BookDetailCubit(bookModel: _book, isSheet: true),
                    child: BlocConsumer<BookDetailCubit, BookDetailState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        final _commenters = context.read<BookDetailCubit>().commenters;
                        final _comments = context.read<BookDetailCubit>().comments;
                        bool isListEmpty() {
                          if (_comments == null && _commenters == null) {
                            return true;
                          }
                          return false;
                        }

                        return SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: context.dynamicHeight(0.02)),
                                  CustomDivider(context: context),
                                  SizedBox(
                                    height: context.dynamicHeight(0.42),
                                    // ignore: prefer_is_empty
                                    child: state is Loading
                                        ? const Center(child: Text("No comments yet"))
                                        : isListEmpty()
                                            ? const Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            : _commenters?.length == _comments?.length
                                                ? ListView.separated(
                                                    shrinkWrap: true,
                                                    separatorBuilder: (context, index) =>
                                                        const Divider(thickness: 1),
                                                    itemCount: _comments?.length ?? 0,
                                                    itemBuilder: (context, index) {
                                                      return ListTile(
                                                        leading: CustomCircleAvatar(
                                                          size: 10,
                                                          avatarUrl: _commenters?[index].imageUrl,
                                                        ),
                                                        title: Text(
                                                            "${_commenters?[index].userName ?? "null username"} : ${_comments?[index].comment ?? "null comment"}"),
                                                      );
                                                    })
                                                : SizedBox(
                                                    height: context.dynamicHeight(0.42),
                                                    child: const Center(child: CircularProgressIndicator())),
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
                                            borderRadius: BorderRadiusConst.normal,
                                            gapPadding: 20,
                                          )),
                                          controller: commentController,
                                          onSubmitted: (v) {
                                            context.read<BookDetailCubit>().writeComment(v, context, _book);
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

  // SingleChildScrollView body(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Card(
  //           elevation: 10,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
  //           child: SizedBox(
  //             height: context.dynamicHeight(0.4),
  //             child: bookThumbnail(context),
  //           ),
  //         ),
  //         SizedBox(height: context.dynamicHeight(0.02)),
  //         Text(bookModel?.volumeInfo?.title ?? StringConstants().notFound),
  //         Text(bookModel?.volumeInfo?.authors?.first ?? StringConstants().notFound,
  //             style: Theme.of(context).textTheme.bodyText1),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(bookModel?.volumeInfo?.ratingsCount?.toString() ?? ""),
  //             if (bookModel?.volumeInfo?.ratingsCount != null &&
  //                 bookModel?.volumeInfo?.ratingsCount.toString() != "")
  //               const Icon(Icons.star)
  //           ],
  //         ),
  //         const Divider(thickness: 1),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Column(
  //               children: [
  //                 bookModel?.volumeInfo?.pageCount != null ? const Text("Page number:") : const SizedBox(),
  //                 bookModel?.volumeInfo?.language != null ? const Text("Language:") : const SizedBox(),
  //                 bookModel?.volumeInfo?.publishedDate != null
  //                     ? const Text("Publish Date:")
  //                     : const SizedBox(),
  //                 bookModel?.volumeInfo?.categories?.first != null
  //                     ? const Text("Categories")
  //                     : const SizedBox()
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 bookModel?.volumeInfo?.pageCount != null
  //                     ? Text(bookModel?.volumeInfo?.pageCount?.toString() ?? "Unknown")
  //                     : const SizedBox(),
  //                 bookModel?.volumeInfo?.language != null
  //                     ? Text(bookModel?.volumeInfo?.language ?? "")
  //                     : const SizedBox(),
  //                 bookModel?.volumeInfo?.publishedDate != null
  //                     ? Text(bookModel?.volumeInfo?.publishedDate ?? "")
  //                     : const SizedBox(),
  //                 bookModel?.volumeInfo?.categories != null
  //                     ? Text(bookModel?.volumeInfo?.categories?.first ?? "null")
  //                     : const SizedBox()
  //               ],
  //             )
  //           ],
  //         ),
  //         const Divider(),
  //         Padding(
  //           padding: context.horizontalPaddingNormal,
  //           child: Text(bookModel?.volumeInfo?.description?.toString() ?? StringConstants().notFound,
  //               style: Theme.of(context).textTheme.bodyLarge),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ClipRRect bookThumbnail(BuildContext context) {
  //   return ClipRRect(
  //     borderRadius: BorderRadiusConst.normal,
  //     child: bookModel?.volumeInfo?.imageLinks?.thumbnail == null
  //         ? Container(
  //             constraints: BoxConstraints(minHeight: context.dynamicHeight(0.3)),
  //             child: Image.asset(LogoPaths.dummyBook),
  //           )
  //         : Image.network(bookModel?.volumeInfo?.imageLinks?.thumbnail ?? "", fit: BoxFit.contain),
  //   );
  // }

  // AppBar appBar() => AppBar(elevation: 0)
}
