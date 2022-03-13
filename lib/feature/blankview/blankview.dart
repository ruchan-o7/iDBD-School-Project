import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/blankview/model/searched_book_model.dart';
import 'package:school_project_ibdb/feature/blankview/service/search_book_service.dart';

class BlankView extends StatefulWidget {
  const BlankView({
    Key? key,
  }) : super(key: key);
  // final UserResponseModel model;

  @override
  State<BlankView> createState() => _BlankViewState();
}

class _BlankViewState extends State<BlankView> {
  SearchBookModel? model2;
  VolumeInfo? tempModel;
  late ISearchBookService service;
  @override
  void initState() {
    service = SearchBookService(Dio());
    init();
    super.initState();
  }

  void init() async {
    model2 = await service.searchByName("intibah");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: model2 == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  tempModel = model2?.items?[index].volumeInfo;
                  return Card(
                    child: ListTile(
                      title: Text(tempModel?.title ?? "null"),
                      subtitle: Text("${tempModel?.authors}"),
                      leading: tempModel?.imageLinks == null
                          ? null
                          : Image.network(
                              tempModel?.imageLinks?.thumbnail ?? "",
                            ),
                      trailing: Text("${tempModel?.categories}"),
                    ),
                  );
                },
                itemCount: model2?.items?.length,
              ),
      ),
    );
  }
}
