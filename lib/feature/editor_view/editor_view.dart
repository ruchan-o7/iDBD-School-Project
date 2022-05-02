import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class EditorView extends StatelessWidget {
  const EditorView({Key? key}) : super(key: key);
  final _imageUrl =
      "https://media.istockphoto.com/photos/majestic-red-stag-in-yellowing-autumn-meadow-picture-id140157656?s=170667a";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [userProfile(context), optionsCards(context)],
          ),
        ));
  }

  Expanded optionsCards(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: context.dynamicWidth(0.1),
          mainAxisSpacing: context.dynamicWidth(0.1),
        ),
        children: [
          GestureDetector(
              onTap: () {}, child: const Card(elevation: 5, child: Center(child: Text("Add Book")))),
          GestureDetector(
              onTap: () {}, child: const Card(elevation: 5, child: Center(child: Text("Remove Book")))),
          GestureDetector(
              onTap: () {}, child: const Card(elevation: 5, child: Center(child: Text("Category Add")))),
          GestureDetector(
              onTap: () {}, child: const Card(elevation: 5, child: Center(child: Text("Edit Category")))),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Editor Page',
        style: Theme.of(context).textTheme.headline4,
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  Card userProfile(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                  padding: context.paddingNormal,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(_imageUrl), radius: context.dynamicWidth(0.15))),
              Positioned(
                  bottom: context.dynamicHeight(0.02),
                  right: context.dynamicHeight(0.01),
                  child: const Icon(Icons.add_a_photo)),
            ],
          ),
          Padding(
            padding: context.horizontalPaddingMedium,
            child: Column(
              children: [
                Text("User name", style: Theme.of(context).textTheme.headline5),
                Text("Unvan", style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          )
        ],
      ),
    );
  }
}
