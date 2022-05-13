import 'package:flutter/material.dart';

class Categories {
  final List<String>? _categories = [
    "Fiction",
    "History",
    "Turkey",
    "Authors,Turkish",
    "Horses",
    "Utopias",
    "Political science",
    "Antiques & Collectibles",
    "Fathers and sons literature",
    "Fathers and sons",
    "Juvenile Nonfiction",
    "Architecture",
    "Art",
    "Children's stories",
    "Philosophy",
    "Drama",
    "German literature",
    "Fantasy fiction",
    "Adventure stories, french",
    "Literary Collecitons",
    "Children's stories, French",
    "Ex-convicts",
    "Computers",
    "Business & Economics",
    "Social Science",
    "Russian literature",
    "Short stories, Turkish",
    "Juvenile Fiction",
  ];
  static Categories? _instance;
  static Categories get instance {
    if (_instance != null) return _instance!;
    _instance = Categories._init();
    return _instance!;
  }

  Categories._init();
  List<String>? get getCategorieList => _categories;
  List<Text>? toTextWidget() {
    return _categories?.map((e) => Text(e)).toList();
  }

  List<Tab>? toTab() {
    return _categories
        ?.map(
          (e) => Tab(
            child: Text(e, style: const TextStyle(color: Colors.black)),
          ),
        )
        .toList();
  }

  get getLength => _categories?.length;
}
