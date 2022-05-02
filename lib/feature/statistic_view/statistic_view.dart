import 'package:flutter/material.dart';

///This view will fetch data from Firebase !!!!!!!!!!
class StatisticView extends StatelessWidget {
  StatisticView({Key? key}) : super(key: key);

  final List<String> categories = [
    "History",
    "Romance",
    "Horror",
    "Criminal",
  ];
  String imageUrl =
      "https://media.istockphoto.com/photos/majestic-red-stag-in-yellowing-autumn-meadow-picture-id140157656?s=170667a";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
          centerTitle: true,
          leading: const Icon(Icons.more_vert),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => categoriList(),
          itemCount: 15,
        ));
  }

  Card categoriList() => Card(
        child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
            title: Row(
              children: [
                Column(
                  children: categories.asMap().keys.map((e) => Text((e + 1).toString() + ": ")).toList(),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categories.map((e) => Text("$e $e")).toList()),
              ],
            )),
      );
}
