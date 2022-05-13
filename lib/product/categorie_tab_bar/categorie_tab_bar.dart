import 'package:flutter/material.dart';

class CategoriesTabBarItemModel {
  final String title;
  CategoriesTabBarItemModel({
    required this.title,
  });
}

class CategoriesTabBarListModel {
  late final List<CategoriesTabBarItemModel> _list;
  CategoriesTabBarListModel() {
    _list = [
      CategoriesTabBarItemModel(title: "Novel"),
      CategoriesTabBarItemModel(title: "Self-Love"),
      CategoriesTabBarItemModel(title: "Science"),
      CategoriesTabBarItemModel(title: "Romance"),
      CategoriesTabBarItemModel(title: "Fiction"),
      CategoriesTabBarItemModel(title: "Crime"),
    ];
  }
  List<Text> toWidget() {
    return _list.map((e) => Text(e.title)).toList();
  }
}
