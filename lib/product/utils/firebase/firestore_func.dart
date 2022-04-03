import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../feature/sign_up/model/signup_model.dart';

abstract class IFirestoreFuncs {
  final FirebaseFirestore instance;

  IFirestoreFuncs(this.instance);
  Future<void> addUserWithSet(String name, String e_mail, String password);
  Future<void> addUserWithSetModel(UserSignUpModel model);
  Future uploadFromGalleryImage(BuildContext context, User? user);
}

class FirestoreFunctions extends IFirestoreFuncs {
  // final database = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? filePath;

  FirestoreFunctions(FirebaseFirestore instance) : super(instance);
  @override
  Future<void> addUserWithSet(String name, String e_mail, String password) async {
    await instance.collection("users").doc().set({"user_name": name, "e-mail": e_mail, "password": password});
  }

  @override
  Future<void> addUserWithSetModel(UserSignUpModel model) async {
    await instance.collection("users").doc().set(model.toJson());
  }

  @override

  ///Uploads image to firebase and applies to profile url
  Future uploadFromGalleryImage(BuildContext context, User? user) async {
    final XFile? _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_selectedImage != null) {
      File _imageFile = File(_selectedImage.path);
      final _uploadTask =
          await _storage.ref("/${user?.displayName}_files/${user?.uid}/userImage").putFile(_imageFile);
      await user?.updatePhotoURL(await _uploadTask.ref.getDownloadURL());
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to upload photo")));
    }

    return user?.photoURL;
  }
}
