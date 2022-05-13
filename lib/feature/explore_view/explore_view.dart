import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/book_detail/book_detail_view.dart';
import '../../product/home_book_card/home_book_card.dart';
import 'cubit/explore_cubit.dart';

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
              body: state is BooksDownloading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        var _model = context.read<ExploreCubit>().exploreBooks?.items?[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetail(bookModel: _model),
                                ));
                          },
                          child: ListBookCard(
                            context: context,
                            model: _model?.volumeInfo,
                          ),
                        );
                      },
                      itemCount: context.read<ExploreCubit>().exploreBooks?.items?.length,
                    ));
        },
      ),
    );
  }
}
