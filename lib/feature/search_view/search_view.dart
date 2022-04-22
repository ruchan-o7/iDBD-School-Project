import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/search_view/search_view_model.dart';
import '../../product/base_model/book_response_mode.dart';
import '../login_screen/view/login_card_view.dart';
import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_btn.dart';
import '../login_screen/view/sign_in_view.dart';
import '../../core/network/NetworkManager.dart';
import 'model/searched_book_model.dart';
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
            appBar: AppBar(
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      context
                          .read<SearchViewCubit>()
                          .searchBooks(context.read<SearchViewCubit>().searchController.text);
                    },
                    icon: Icon(Icons.search))
              ],
              title: TextField(
                focusNode: context.read<SearchViewCubit>().searchNode,
                controller: context.read<SearchViewCubit>().searchController,
                onSubmitted: (v) {
                  context.read<SearchViewCubit>().searchBooks(v);
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: state is SearchViewInitial
                        ? null
                        // const Center(
                        //     child: CircularProgressIndicator(),
                        //   )
                        : state is SearchDone
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  VolumeInfo? tempModel =
                                      context.read<SearchViewCubit>().results?.items?[index].volumeInfo;
                                  return Card(
                                    child: ListTile(
                                      title: Text(tempModel?.title ?? "null"),
                                      subtitle: Text("${tempModel?.authors?.first}"),
                                      leading: tempModel?.imageLinks == null
                                          ? null
                                          : Image.network(
                                              tempModel?.imageLinks?.thumbnail ?? "",
                                            ),
                                      trailing: Text(tempModel?.categories?.first ?? ""),
                                    ),
                                  );
                                },
                                itemCount: context.read<SearchViewCubit>().results?.items?.length,
                              )
                            : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
