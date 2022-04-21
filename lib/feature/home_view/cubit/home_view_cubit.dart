import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';
import 'package:school_project_ibdb/product/utils/firebase/firebase_auth.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit({this.currentUser}) : super(HomeViewInitial());

  final User? currentUser;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  logOut(BuildContext context) {
    Authentication().signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginCardView(),
    ));
  }

  goToPage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }
}
