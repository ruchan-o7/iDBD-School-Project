import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../sign_up/model/signup_model.dart';

import '../../../product/utils/firebase/firestore_func.dart';
import '../../login_screen/view/login_card_view.dart';

part 'usersettings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit({required this.auth, this.user}) : super(UsersettingsInitial());
  FirebaseAuth auth;
  User? user;

  changePage(BuildContext context, Widget Destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Destination,
        ));
  }

  changeImage(BuildContext context) async {
    await FirestoreFunctions().uploadFromGalleryImage(context, FirebaseAuth.instance.currentUser);
  }

  logOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginCardView(),
        ));
  }
}
