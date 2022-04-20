import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/explore_view/cubit/explore_cubit.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';

import '../../product/book_card/book_card.dart';
import 'package:kartal/kartal.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {
          if (state is BooksDownloading) {}
        },
        builder: (context, state) {
          return Scaffold(
            body: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 9 / 13,
              ),
              itemBuilder: (contex, index) {
                if (state is BooksDownloading) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: contex.dynamicHeight(0.03)),
                        Card(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                  context
                                          .read<ExploreCubit>()
                                          .exploreBooks
                                          ?.items?[index]
                                          .volumeInfo
                                          ?.imageLinks
                                          ?.thumbnail ??
                                      "",
                                  fit: BoxFit.fitWidth),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    context
                                            .read<ExploreCubit>()
                                            .exploreBooks
                                            ?.items?[index]
                                            .volumeInfo
                                            ?.title ??
                                        "null title",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemCount: context.read<ExploreCubit>().exploreBooks?.items?.length,
            ),
          );
        },
      ),
    );
  }

  BookCard bookCards() {
    return BookCard(
      bookModel: Items(
          volumeInfo: VolumeInfo(
              title: "test kitap", imageLinks: ImageLinks(thumbnail: "https://picsum.photos/200/300"))),
    );
  }
}
