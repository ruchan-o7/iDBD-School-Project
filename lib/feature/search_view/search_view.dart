import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_screen/view/login_card_view.dart';
import '../../core/constants/string_constants.dart';
import '../../core/custom/custom_btn.dart';
import '../login_screen/view/sign_in_view.dart';
import '../../core/network/NetworkManager.dart';
import 'model/searched_book_model.dart';
import 'service/search_book_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchBookModel? model2;
  late ISearchBookService service;
  var controller = TextEditingController();
  @override
  void initState() {
    service = SearchBookService(NetworkManager.instance);
    super.initState();
  }

  void init(String val) async {
    await Future.delayed(const Duration(seconds: 2));
    if (val.isEmpty) {
      model2 = null;
    } else {
      model2 = await service.searchByName(val);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                print("${FirebaseAuth.instance.currentUser}");
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginCardView()));
              },
              child: Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: (val) async {
              init(val);
            },
          ),
          Expanded(
            child: Center(
              child: model2 == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        VolumeInfo? tempModel =
                            model2?.items?[index].volumeInfo;
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
          ),
        ],
      ),
    );
  }
}
