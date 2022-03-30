import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../../feature/search_view/search_view.dart';

abstract class IAuthentication {
  FirebaseAuth auth;

  IAuthentication(this.auth);

  Future<User?> eMailSignIn(
      {required String eMail,
      required String password,
      required BuildContext context});
  Future<void> signUp(String email, String password, BuildContext context);
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
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No user found")));
      }
    }
    return user;
  }

  @override
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
