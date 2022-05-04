import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/product/publisher_user_model/publisher_user.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

part 'publisher_state.dart';

class PublisherCubit extends Cubit<PublisherState> {
  PublisherCubit(this.context) : super(PublisherInitial()) {
    getUserData();
  }
  BuildContext context;

  final FirestoreFunctions _functions = FirestoreFunctions();
  getUserData() async {
    final currentUser = await _functions.getPublisherUser(FirebaseAuth.instance.currentUser?.uid);
    if (currentUser?.userName == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
    }
    emit(DataFetched(currentUser: currentUser));
  }
}
