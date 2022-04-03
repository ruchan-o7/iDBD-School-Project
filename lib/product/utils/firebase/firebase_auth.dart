import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../feature/sign_up/model/signup_model.dart';

abstract class IAuthentication {
  FirebaseAuth auth;

  IAuthentication(this.auth);

  Future<User?> eMailSignIn(
      {required String eMail,
      required String password,
      required BuildContext context});
  Future<void> signUp(UserSignUpModel model, BuildContext context);
  Future<void> signOut();
  Future<FirebaseApp> initializeFirebase();
}

class Authentication extends IAuthentication {
  Authentication(FirebaseAuth auth) : super(auth = FirebaseAuth.instance);

  @override
  Future<User?> eMailSignIn(
      {required String eMail,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: eMail, password: password);
      user = userCredential.user;
      user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _showSnackbar("User not found", context);
      }
    }
    return user;
  }

  @override
  Future<void> signUp(UserSignUpModel model, BuildContext context) async {
    try {
      UserCredential _user = await auth.createUserWithEmailAndPassword(
          email: model.userMail!, password: model.userPassword!);
      await _user.user?.updateDisplayName(model.userName);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _showSnackbar("Mail already using", context);
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  _showSnackbar(String data, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
