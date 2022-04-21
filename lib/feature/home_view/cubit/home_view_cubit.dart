import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';
import 'package:school_project_ibdb/product/utils/firebase/firebase_auth.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(HomeViewInitial()) {
    init();
  }

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final Authentication _auth = Authentication();

  logOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginCardView(),
    ));
  }

  init() async {
    await _auth.initializeFirebase();
  }

  goToPage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }
}
