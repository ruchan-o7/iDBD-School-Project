import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../feature/sign_up/model/signup_model.dart';
import '../../random_pic_generator/random_pict_generator.dart';
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
      await _firestoreFunctions.addUser(model.copyWith(userUid: _user.user?.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _showSnackbar("Mail already using", context);
      }
    }
  }

  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "auth/invalid-email") {
        _showSnackbar("Invalid e-mail", context);
        return false;
      } else if (e.code == "auth/user-not-found") {
        _showSnackbar("User not found", context);
        return false;
      } else {
        _showSnackbar("Onknown failure", context);
        log(e.message ?? "null message");
        return false;
      }
    }
  }

  Future<bool> confirmResetPass(context, {required String code, required String newPassword}) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      return true;
    } on FirebaseAuthException catch (e, stack) {
      if (e.code == "expired-action-code") {
        _showSnackbar("Code is expired", context);
        return false;
      } else if (e.code == "invalid-action-code") {
        _showSnackbar("Invalid action code", context);
        return false;
      } else if (e.code == "user-not-found") {
        _showSnackbar("User not found", context);
        return false;
      } else if (e.code == "weak-password") {
        _showSnackbar("Password is too weak", context);
      } else {
        _showSnackbar("Unknown failure", context);
        return false;
      }
    }
    return false;
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
