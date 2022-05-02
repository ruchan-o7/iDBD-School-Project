import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kartal/kartal.dart';

import '../../core/constants/logo_path.dart';
import 'search_view_model.dart';
import '../../product/book_card/book_card.dart';
import '../../product/base_model/book_response_mode.dart';
import 'service/search_book_service.dart';

class SearchView extends StatelessWidget {
  SearchView({
    Key? key,
  }) : super(key: key);

  late ISearchBookService service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchViewCubit(),
      child: BlocConsumer<SearchViewCubit, SearchViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(context),
            body: state is SearchViewInitial
                ? null
                : state is SearchDone
                    // ignore: prefer_is_empty
                    ? context.read<SearchViewCubit>().searchedBookFromDatabase?.length != 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("        From Google              From Our Database"),
                              const Divider(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(child: searchedFromGoogle(context)),
                                    Expanded(
                                      child: formDatabases(context),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : searchedFromGoogle(context)
                    : centerProgress(),
          );
        },
      ),
    );
  }

  ListView formDatabases(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          context
              .read<SearchViewCubit>()
              .goToBook(context.read<SearchViewCubit>().searchedBookFromDatabase?[index], context);
        },
        child: BookCard(bookModel: context.read<SearchViewCubit>().searchedBookFromDatabase?[index]),
      ),
      itemCount: context.read<SearchViewCubit>().searchedBookFromDatabase?.length,
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [searchIcon(context)],
      title: searchBar(context),
    );
  }

  IconButton searchIcon(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<SearchViewCubit>().searchBooks(context.read<SearchViewCubit>().searchController.text);
        },
        icon: const Icon(Icons.search));
  }

  TextField searchBar(BuildContext context) {
    return TextField(
      focusNode: context.read<SearchViewCubit>().searchNode,
      controller: context.read<SearchViewCubit>().searchController,
      onSubmitted: (v) {
        context.read<SearchViewCubit>().searchBooks(v);
      },
    );
  }

  ListView searchedFromGoogle(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        VolumeInfo? tempModel = context.read<SearchViewCubit>().results?.items?[index].volumeInfo;
        return Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              context
                  .read<SearchViewCubit>()
                  .goToBook(context.read<SearchViewCubit>().results?.items?[index], context);
            },
            child: Column(
              children: [
                tempModel?.imageLinks == null
                    ? Container(
                        constraints: BoxConstraints(minHeight: context.dynamicHeight(0.2)),
                        child: Image.asset(LogoPaths.dummyBook),
                      )
                    : Container(
                        constraints: BoxConstraints(maxHeight: context.dynamicHeight(0.2)),
                        child: Image.network(tempModel?.imageLinks?.thumbnail ?? "")),
                Text(tempModel?.title ?? "unknown title", style: Theme.of(context).textTheme.bodyLarge),
                Text(tempModel?.authors?.first ?? "", style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        );
      },
      itemCount: context.read<SearchViewCubit>().results?.items?.length,
    );
  }

  Center centerProgress() => const Center(child: CircularProgressIndicator());
}
