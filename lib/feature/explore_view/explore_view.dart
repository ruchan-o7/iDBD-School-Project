import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/explore_cubit.dart';
import '../../product/book_card/book_card.dart';
import 'package:kartal/kartal.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 9 / 10,
              ),
              itemBuilder: (context, index) {
                if (state is BooksDownloading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  final data = context.read<ExploreCubit>().exploreBooks?.items?[index];
                  return Column(
                    children: [
                      SizedBox(height: context.dynamicHeight(0.03)),
                      BookCard(
                        bookModel: data,
                      )
                    ],
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
