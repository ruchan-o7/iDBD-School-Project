import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

import '../../sign_up/model/signup_model.dart';

part 'profileview_state.dart';

class ProfileviewCubit extends Cubit<ProfileviewState> {
  ProfileviewCubit() : super(ProfileviewInitial()) {
    getLikedBookNumber();
  }

  FirestoreFunctions _functions = FirestoreFunctions();
  UserSignUpModel? currUser;
  int selectedIndex = 0;

  Future<void> getLikedBookNumber() async {
    var temp = await _functions.getDocumentData(FirebaseAuth.instance.currentUser);
    if (temp is Map<String, dynamic>) {
      currUser = UserSignUpModel.fromJson(temp);
    }
    log(temp?.entries.toString() ?? "null entries");
    emit(RefreshPage());
  }
}
