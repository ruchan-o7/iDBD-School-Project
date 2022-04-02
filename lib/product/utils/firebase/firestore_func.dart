import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../feature/sign_up/model/signup_model.dart';

abstract class IFirestoreFuncs {
  final FirebaseFirestore instance;

  IFirestoreFuncs(this.instance);
  Future<void> addUserWithSet(String name, String e_mail, String password);
  Future<void> addUserWithSetModel(UserSignUpModel model);
  Future uploadFromGalleryImage(BuildContext context, {XFile? imagePath});
}

class FirestoreFunctions extends IFirestoreFuncs {
  // final database = FirebaseFirestore.instance;

  FirebaseStorage _storage = FirebaseStorage.instance;
  String? filePath;

  FirestoreFunctions(FirebaseFirestore instance) : super(instance);
  @override
  Future<void> addUserWithSet(
      String name, String e_mail, String password) async {
    await instance
        .collection("users")
        .doc()
        .set({"user_name": name, "e-mail": e_mail, "password": password});
  }

  @override
  Future<void> addUserWithSetModel(UserSignUpModel model) async {
    await instance.collection("users").doc().set(model.toJson());
  }

  @override
  Future uploadFromGalleryImage(BuildContext context,
      {XFile? imagePath}) async {
    String uploadFileName =
        DateTime.now().microsecondsSinceEpoch.toString() + ".jpg";
    Reference reference = _storage.ref().child("images").child(uploadFileName);
    if (imagePath != null) {
      UploadTask _uploadTask = reference.putFile(File(imagePath.path));
      _uploadTask.snapshotEvents.listen((event) {});
      await _uploadTask.whenComplete(() async {
        filePath = await _uploadTask.snapshot.ref.getDownloadURL();
        return filePath;
      });
    }

    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("failed to upload photo")));
  }
}
