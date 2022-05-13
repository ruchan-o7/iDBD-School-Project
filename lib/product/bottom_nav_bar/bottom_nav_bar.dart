import 'package:flutter/material.dart';

class BottomNavBarItemModel {
  final IconData icon;
  final String label;

  BottomNavBarItemModel(this.icon, this.label);
}

class BottomNavBarListModel {
  late final List<BottomNavBarItemModel> _items;

  BottomNavBarListModel() {
    _items = [
      BottomNavBarItemModel(Icons.home, "Home"),
      BottomNavBarItemModel(Icons.explore, "Explore"),
      BottomNavBarItemModel(Icons.search, "Search"),
      BottomNavBarItemModel(Icons.person, "Profile"),
    ];
  }

  List<BottomNavigationBarItem> toWidget() {
    return _items.map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.label)).toList();
  }
}
