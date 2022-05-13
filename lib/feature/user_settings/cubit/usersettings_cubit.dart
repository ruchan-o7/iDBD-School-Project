import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../product/utils/firebase/firestore_func.dart';
import '../../login_screen/view/login_card_view.dart';

part 'usersettings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit({required this.auth, this.user}) : super(UsersettingsInitial());
  FirebaseAuth auth;
  User? user;

  changePage(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
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
          builder: (context) => const LoginCardView(),
        ));
  }
}
