import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_view_model.dart';
import '../../product/book_card/book_card.dart';
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
                  ? const Center(
                      child: Text("search something"),
                    )
                  : state is SearchDone
                      // ignore: prefer_is_empty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Expanded(
                              child: searchedFromGoogle(context),
                            ),
                          ],
                        )
                      : searchedFromGoogle(context));
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
        icon: const Icon(Icons.search));
  }

  TextField searchBar(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: "Harry Potter"),
      focusNode: context.read<SearchViewCubit>().searchNode,
      controller: context.read<SearchViewCubit>().searchController,
      onSubmitted: (v) {
        context.read<SearchViewCubit>().searchBooks(v);
      },
    );
  }

  Widget searchedFromGoogle(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final _tempModel = context.read<SearchViewCubit>().results?.items?[index];
        return InkWell(
            onTap: () {
              context
                  .read<SearchViewCubit>()
                  .goToBook(context.read<SearchViewCubit>().results?.items?[index], context);
            },
            child: BookCard(bookModel: _tempModel)
            // Column(
            //   children: [
            //     tempModel?.imageLinks == null
            //         ? Container(
            //             constraints: BoxConstraints(minHeight: context.dynamicHeight(0.2)),
            //             child: Image.asset(LogoPaths.dummyBook),
            //           )
            //         : Container(
            //             constraints: BoxConstraints(maxHeight: context.dynamicHeight(0.2)),
            //             child: Image.network(tempModel?.imageLinks?.thumbnail ?? "")),
            //     Text(tempModel?.title ?? "unknown title", style: Theme.of(context).textTheme.bodyLarge),
            //     Text(tempModel?.authors?.first ?? "", style: Theme.of(context).textTheme.bodySmall)
            //   ],
            // ),
            );
      },
      itemCount: context.read<SearchViewCubit>().results?.items?.length,
    );
  }

  Center centerProgress() => const Center(child: CircularProgressIndicator());
}
