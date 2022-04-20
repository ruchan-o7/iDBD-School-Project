import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/feature/home_view/home_view.dart';
import 'package:school_project_ibdb/feature/search_view/search_view.dart';

import '../../explore_view/explore_view.dart';
import '../../profile_view/profile_view.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());
  int selectedIndex = 0;

  void selectPage(int value) {
    selectedIndex = value;
    emit(PageChangedState());
  }

  List<Widget> pages = [HomeView(), ExploreView(), SearchView(), ProfileView()];
}
