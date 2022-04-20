import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit({this.currentUser}) : super(HomeViewInitial());

  final User? currentUser;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  goToPage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }
}
