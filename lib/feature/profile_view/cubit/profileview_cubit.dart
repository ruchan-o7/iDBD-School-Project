import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';
import 'package:school_project_ibdb/product/utils/firebase/models/rt_user_model.dart';

import '../../../product/base_model/book_response_mode.dart';
import '../../sign_up/model/signup_model.dart';

part 'profileview_state.dart';

class ProfileviewCubit extends Cubit<ProfileviewState> {
  ProfileviewCubit() : super(ProfileviewInitial()) {
    getLikedBookNumber();
    getData();
  }

  FirestoreFunctions _functions = FirestoreFunctions();
  UserSignUpModel? currUser;
  int selectedIndex = 0;
  RTUserModel? rtUserModel;
  List<Items>? likedBooks = [];
  List<Items>? ownedBooks = [];

  Future<void> getLikedBookNumber() async {
    var _temp = await _functions.getDocumentData(FirebaseAuth.instance.currentUser);
    // if (temp is Map<String, dynamic>) {
    //   currUser = UserSignUpModel.fromJson(temp);
    // }
    // log(temp?.entries.toString() ?? "null entries");
    currUser = _temp;
    emit(RefreshPage());
  }

  Future<void> getData() async {
    // rtUserModel = await _functions.readUserDataOnce();

    // await getLikedBooks(rtUserModel);
    // await getOwnedBooks(rtUserModel);
    currUser = await _functions.getDocumentData(FirebaseAuth.instance.currentUser);
    await getLikedBooks(currUser);
    await getOwnedBooks(currUser);
  }

  Future<void> getLikedBooks(UserSignUpModel? userModel) async {
    for (var item in userModel?.likedBooks ?? []) {
      final _data = await _functions.getBookById(item ?? "null");
      if (_data != null) {
        likedBooks?.add(_data);
      }
    }
    emit(RefreshPage());
  }

  Future<void> getOwnedBooks(UserSignUpModel? userModel) async {
    for (var item in userModel?.ownedBooks ?? []) {
      final _data = await _functions.getBookById(item ?? "null");
      if (_data != null) {
        ownedBooks?.add(_data);
      }
    }
    emit(RefreshPage());
  }
}
