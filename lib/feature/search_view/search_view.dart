import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_view_model.dart';
import '../../product/book_card/book_card.dart';
import 'service/search_book_service.dart';
import '../../core/extension/string_extension.dart';

class SearchView extends StatelessWidget {
  SearchView({
    Key? key,
  }) : super(key: key);

  late ISearchBookService service;
  final String searchText = "search something";

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
                ? Center(
                    child: Text(searchText.toTitleCase()),
                  )
                : state is SearchingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is SearchDone
                        ? Column(
                            children: [const Divider(), Expanded(child: searchedFromGoogle(context, state))],
                          )
                        : const SizedBox(),
          );
        },
      ),
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
        icon: Icon(Icons.search, color: Theme.of(context).primaryColorDark));
  }

  TextField searchBar(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: "Harry Potter", filled: true, fillColor: Colors.white38),
      focusNode: context.read<SearchViewCubit>().searchNode,
      controller: context.read<SearchViewCubit>().searchController,
      onSubmitted: (v) {
        context.read<SearchViewCubit>().searchBooks(v);
      },
    );
  }

  Widget searchedFromGoogle(BuildContext context, SearchDone state) {
    return state.results?.items != null
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final _tempModel = state.results;
              return InkWell(
                  onTap: () {
                    context.read<SearchViewCubit>().goToBook(_tempModel?.items?[index], context);
                  },
                  child: BookCard(bookModel: _tempModel?.items?[index]));
            },
            itemCount: state.results?.items?.length,
          )
        : const Center(
            child: Text("Couldn't find"),
          );
  }

  Center centerProgress() => const Center(child: CircularProgressIndicator());
}
