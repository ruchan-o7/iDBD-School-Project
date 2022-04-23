import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';
import 'package:school_project_ibdb/product/comment_model/comment_model.dart';
import 'package:school_project_ibdb/product/utils/firebase/models/rt_user_model.dart';

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
        .doc(model.userUid)
        .update({"imageUrl": model.imageUrl})
        .then((value) => log("user updated"))
        .catchError((error) => log("Failed to update user =>$error"));
  }

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

  ///Finds user in firestore by user uid
  Future<Map<String, dynamic>?> getDocumentData(User? currentUser) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docSnap =
        (await _firestore.collection("users").where("userUID", isEqualTo: currentUser?.uid).get()).docs;

    Map<String, dynamic>? _data;
    _docSnap.forEach((element) {
      _data = element.data();
    });
    return _data;
  }

  ///Finds books from databases by id
  getBookById(String id) async {
    final _docSnap = (await _firestore.collection("books").where("id", isEqualTo: id).get()).docs;
    Map<String, dynamic> _data = {};
    _docSnap.forEach((element) {
      _data = element.data();
    });
    return Items.fromJson(_data);
  }

  ///Searchs From FireStore not Google books api.
  ///Returns Items model
  searchBookFromName(String bookName) async {
    final _snap = (await _firestore
            .collection("books")
            .where("volumeInfo.title", isGreaterThanOrEqualTo: bookName)
            .get())
        .docs;

    List<Items>? _books = [];
    for (var item in _snap) {
      _books.add(Items.fromJson(item.data()));
    }
    log(_books.length.toString());
    return _books;
  }

  //-----------------------------------------------------------------------------
  //REALTIME DATABASE
  final FirebaseDatabase _rtDatabase = FirebaseDatabase.instance;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void readDataContinously() {
    _ref.onValue.listen((event) {
      final data = event.snapshot.value;
      log(data.toString());
    });
  }

  ///Reads user data from realtime database only once
  Future readUserDataOnce() async {
    List<RTUserModel> list;
    final snapshot = await _ref.child("/users/0").get();

    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      return RTUserModel.fromJson(data);
    } else {
      print("No data");
    }
  }

  ///Reads user data from realtime database only once
  Future readCommentData(String? bookID) async {
    final snapshot = await _ref.get();

    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value));
      // final _model = CommentModel.fromMap((jsonDecode(jsonEncode(snapshot.value)).cast<String, dynamic>()));
      // return data;
      // final _model = CommentComment.fromJson(data);
      // List<CommentComment>.from(CommentComment.fromJson(data)).toList();
      try {
        final _model = BaseModel.fromJson(data);
        return _model;
      } catch (e) {}
      // if (data is List) {
      //   for (var item in data) {
      //     liste.add(CommentModelComment.fromJson(item as Map<String, dynamic>));
      //   }
      // }
    } else {}
  }

  ///write comment to realtime datanase
  void writeCommentData(String bookId, CommentModel model) {
    final comment = _ref.child("comments/${bookId}/comment");
    final newComment = comment.push();
    newComment.set(model.toJson());

    //----------------------------
    // newComment.set(commentModel.comments?.first?.toMap());
    // final _newComment = _ref.push();
    // _newComment.set(commentModel.comments?.first?.toMap());
  }

  _showSnackMessage(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
