import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../../feature/search_view/search_view.dart';
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No user found")));
      }
    }
    return user;
  }

  @override
  Future<void> signUp(UserSignUpModel model, BuildContext context) async {
    try {
      if (model != null) {
        final UserCredential _user = await auth.createUserWithEmailAndPassword(
            email: model.userMail!, password: model.userPassword!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Mail already using")));
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
