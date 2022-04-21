import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';

import '../../../feature/sign_up/model/signup_model.dart';

class FirestoreFunctions {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? filePath;

  FirestoreFunctions();

  Future<void> addUser(UserSignUpModel model) async {
    await _firestore.collection("users").doc().set(model.toJson());
  }

  Future<void> addBook(Items model) async {
    await _firestore.collection("books").doc().set(model.toJson());
  }

  ///field name can be: "imageUrl","likedBooks","ownedBook","userMail","userName","userPassword",
  ///Likedbooks and Ownedbooks are [<"String">]
  ///Current updates only photo
  Future updateUserData(UserSignUpModel model, String fieldName) async {
    CollectionReference _user = _firestore.collection(
        "users"); //TODO: fix issue =>  [cloud_firestore/not-found] Some requested document was not found.
    await _user
        .doc(model.userUID)
        .update({"imageUrl": model.imageUrl})
        .then((value) => log("user updated"))
        .catchError((error) => log("Failed to update user =>$error"));
  }

  // Future updateUserUID(String uid) async {
  //   //TODO: DOES NOT UPDATE USER UID
  //   Future.delayed(const Duration(seconds: 1), () async {
  //     // DocumentReference _doc = _storage.
  //     CollectionReference _users = _firestore.collection(
  //         "users"); //WARNING: fix issue =>  [cloud_firestore/not-found] Some requested document was not found.
  //     log(uid);
  //     await _users
  //         .doc(uid)
  //         .update({"userUID": uid})
  //         .then((value) => log("user updated"))
  //         .catchError((error) => log("Failed to update user =>$error"));
  //   });
  // }

  ///Uploads image to firebase and applies to profile url
  Future uploadFromGalleryImage(BuildContext context, User? user) async {
    final XFile? _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_selectedImage != null) {
      File _imageFile = File(_selectedImage.path);
      final _uploadTask =
          await _storage.ref("/${user?.uid}->${user?.displayName}/userImage").putFile(_imageFile);
      await user?.updatePhotoURL(await _uploadTask.ref.getDownloadURL());
      await updateUserData(UserSignUpModel(imageUrl: user?.photoURL), "");
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to upload photo")));
    }

    return user?.photoURL;
  }

  _showSnackMessage(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
