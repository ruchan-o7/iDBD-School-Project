import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../feature/sign_up/model/signup_model.dart';
import 'firestore_func.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreFunctions _firestoreFunctions = FirestoreFunctions();

  Future<User?> eMailSignIn(
      {required String eMail, required String password, required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: eMail, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _showSnackbar("User not found", context);
      }
    }
    return user;
  }

  Future<void> signUp(UserSignUpModel model, BuildContext context) async {
    try {
      final _user =
          await _auth.createUserWithEmailAndPassword(email: model.userMail!, password: model.userPassword!);
      await _user.user?.updateDisplayName(model.userName);
      _user.user?.sendEmailVerification();
      await _firestoreFunctions.addUser(model.copyWith(userUID: _user.user?.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _showSnackbar("Mail already using", context);
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  _showSnackbar(String data, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
