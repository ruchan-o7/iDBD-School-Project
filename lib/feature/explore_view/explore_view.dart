import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/explore_view/cubit/explore_cubit.dart';
// import 'package:school_project_ibdb/feature/search_view/model/searched_book_model.dart';
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  final data = contex.read<ExploreCubit>().exploreBooks?.items?[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [SizedBox(height: contex.dynamicHeight(0.03)), BookCard(bookModel: data)],
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
}
