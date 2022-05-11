import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_project_ibdb/product/publisher_user_model/publisher_user.dart';

import '../../../feature/publisher_view/add_book_view/model.dart';
import '../../base_model/book_response_mode.dart';
import '../../categories_liked_model/categor_liked_model.dart';
import '../../comment_model/comment_model.dart';

import '../../../feature/sign_up/model/signup_model.dart';

class FirestoreFunctions {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? filePath;

  FirestoreFunctions();

  Future<void> addUser(UserSignUpModel model) async {
    await _firestore.collection("users").doc(model.userUid).set(model.toJson());
  }

  Future<void> addBook(Items model) async {
    //! generic type a çevirilmesi gerekiyor
    await _firestore.collection("books").doc().set(model.toJson());
  }

  Future<void> addBookRequest(BookRequestModel model) async {
    await _firestore.collection("books").doc().set(model.toMap());
  }

  ///field name can be: "imageUrl","likedBooks","ownedBook","userMail","userName","userPassword",
  ///Likedbooks and Ownedbooks are [<"String">]
  ///Current updates only photo
  Future updateUserPhotoUrl(String imageUrl, String collectionId) async {
    final _temp = _firestore.collection("users").doc(collectionId);
    await _temp.update({"imageUrl": imageUrl});
    // CollectionReference _user = _firestore.collection("users").doc(collectionId).update({"imageUrl":model.imageUrl});
    // await _user
    //     .doc(collectionId)
    //     .update({"imageUrl": model.imageUrl})
    //     .then((value) => log("user updated"))
    //     .catchError((error) => log("Failed to update user =>$error"));
  }

  ///Uploads image to firebase and applies to profile url
  Future uploadFromGalleryImage(BuildContext context, User? user) async {
    final XFile? _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_selectedImage != null) {
      File _imageFile = File(_selectedImage.path);
      final _uploadTask =
          await _storage.ref("/${user?.uid}->${user?.displayName}/userImage").putFile(_imageFile);
      final _downloadUrl = await _uploadTask.ref.getDownloadURL();
      await user?.updatePhotoURL(_downloadUrl);
      final String? _uid = await getCollectionId(user?.uid);
      await updateUserPhotoUrl(_downloadUrl, _uid ?? "");
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to upload photo")));
    }

    return user?.photoURL;
  }

  Future<String?> uploadImage(XFile? bookimage, String bookId) async {
    if (bookimage != null) {
      final _uploadTask =
          await _storage.ref("/books/$bookId/${bookimage.name}").putFile(File(bookimage.path));
      final _downloadUrl = await _uploadTask.ref.getDownloadURL();
      return _downloadUrl;
    }
    return null;
  }

  ///Finds user in firestore by user uid
  Future<UserSignUpModel> getDocumentData(User? currentUser) async {
    final _docSnap =
        (await _firestore.collection("users").where("userUID", isEqualTo: currentUser?.uid).get()).docs;

    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return UserSignUpModel.fromJson(_data);
  }

  Future<UserSignUpModel?> getUser(String? userUid) async {
    final _docSnap = (await _firestore.collection("users").where("userUID", isEqualTo: userUid).get()).docs;

    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return UserSignUpModel.fromJson(_data);
  }

  Future<PublisherUser?> getPublisherUser(String? userUid) async {
    final _docSnap =
        (await _firestore.collection("publisher_user").where("userId", isEqualTo: userUid).get()).docs;

    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return PublisherUser.fromMap(_data);
  }

  ///Finds books from databases by id
  Future<Items?> getBookById(String id) async {
    final _docSnap = (await _firestore.collection("books").where("id", isEqualTo: id).get()).docs;
    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return Items.fromJson(_data);
  }

  Future<BookRequestModel?> getBookByIdRequested(String id) async {
    final _docSnap = (await _firestore.collection("books").where("id", isEqualTo: id).get()).docs;
    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return BookRequestModel.fromMap(_data);
  }

  ///Finds books from databases by id
  Future<PublisherUser?> getBookByIdPublisherRequest(String userId) async {
    final _docSnap =
        (await _firestore.collection("publisher_user").where("userId", isEqualTo: userId).get()).docs;
    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    return PublisherUser.fromMap(_data);
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
    return _books;
  }

  Future<String?> getCollectionId(String? uid) async {
    if (uid == "") return null;

    final _docSnap = (await _firestore.collection("users").where("userUID", isEqualTo: uid).get()).docs;
    String id = "";
    for (var item in _docSnap) {
      id = item.id;
    }
    return id;
  }

  Future<String?> getCollectionIdPublisher(String? uid) async {
    if (uid == "") return null;

    final _docSnap =
        (await _firestore.collection("publisher_user").where("userId", isEqualTo: uid).get()).docs;
    String id = "";
    for (var item in _docSnap) {
      id = item.id;
    }
    return id;
  }

  Future<void> likeBook(Items? book, User? currentUser) async {
    final id = await getCollectionId(currentUser?.uid);
    await _firestore.collection("users").doc(id).update({
      "likedBooks": FieldValue.arrayUnion(<String>[book?.id ?? "null"])
    });
    if (book != null) {
      if (book.id != null) {
        final _temp = await getBookById(book.id ?? "");
        if (_temp?.id == null) {
          addBook(book);
          writeCategoriesData(book, currentUser);
          return;
        }
      }
    }
  }

  Future<void> unLikeBook(Items? book, User? user) async {
    final _id = await getCollectionId(user?.uid);
    await _firestore.collection("users").doc(_id).update({
      "likedBooks": FieldValue.arrayRemove([book?.id ?? "null"])
    });
  }

  Future<void> removeReq(String? book, String? userid) async {
    final _id = await getCollectionIdPublisher(userid);
    await _firestore.collection("publisher_user").doc(_id).update({
      "onGoingRequests": FieldValue.arrayRemove([book ?? "null"])
    });
  }

  Future<Map<String, int>> getStatistics() async {
    final _dateTime = DateTime.now();
    final _rawData = await _ref.child("categories/${_dateTime.year}/${_dateTime.month}").get();
    Map<String, int> _statistics = {};
    if (_rawData.exists) {
      final Map<String, dynamic> _data = jsonDecode(jsonEncode(_rawData.value));
      final _list = List.from(_data.keys);

      for (int i = 0; i < _data.keys.length; i++) {
        _statistics[_list[i]] = _data.values.elementAt(i).length;
      }
      return _statistics;
    }
    return {};
  } //todo: make suggestion by user's preferences

  Future<bool> checkUserPublisher(String? userUid) async {
    final _docSnap =
        (await _firestore.collection("publisher_user").where("userId", isEqualTo: userUid).get()).docs;

    Map<String, dynamic> _data = {};
    for (var element in _docSnap) {
      _data = element.data();
    }
    if (_data["isPublisher"] == true) {
      return true;
    } else {
      return false;
    }
  }

  //-----------------------------------------------------------------------------
  //REALTIME DATABASE
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  // void readDataContinously() {
  //   _ref.onValue.listen((event) {
  //     final data = event.snapshot.value;
  //   });
  // }

  ///Reads user data from realtime database only once
  // Future readUserDataOnce(BuildContext context) async {
  //   List<RTUserModel> list;
  //   final snapshot = await _ref.child("/users/0").get();

  //   if (snapshot.exists) {
  //     final data = jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
  //     return RTUserModel.fromJson(data);
  //   } else {
  //     _showSnackMessage(context, "Couldn't read data");
  //   }
  // }

  ///Reads user data from realtime database only once
  Future readCommentData(String? bookID) async {
    //!vote data çekiyor
    //! null check yap
    final snapshot = await _ref.child("comments/$bookID/comment").get();

    List<CommentModelFromRTD> _list = [];
    if (snapshot.exists) {
      final _data = jsonDecode(jsonEncode(snapshot.value));

      for (Map<String, dynamic> item in _data.values) {
        // for (Map<String, dynamic> listofMaps in item.values) {
        //   _list.add(CommentModelFromRTD.fromMap(listofMaps));
        // }
        _list.add(CommentModelFromRTD.fromMap(item));
      }
      return _list;
    } else {
      return _list;
    }
  }

  ///write comment to realtime datanase
  Future<void> writeCommentData(String? bookId, User? currentUser, String commentText) async {
    final comment = _ref.child("comments/$bookId/comment");
    final newComment = comment.push();
    await newComment.set({
      "commenterId": currentUser?.uid,
      "comment": commentText,
    });
  }

  Future<void> giveVote(String? bookId, bool isUp, bool isVotedAlready) async {
    final vote = _ref.child("comments/$bookId/votes");

    final _checkData = await getVoteData(bookId);
    // await _ref.child("comments/$bookId/votes").push().set({"up": 0, "down": 0});
    if (_checkData != null) {
      if (isVotedAlready) {
        if (isUp) {
          var up = _checkData["up"];
          if (up <= 0) {
            await vote.update({"up": 0});
          } else {
            await vote.update({"up": (up - 1)});
          }
        } else {
          var down = _checkData["down"];
          await vote.update({"down": (1 + down)});
        }
      } else {
        if (isUp) {
          var up = _checkData["up"];
          await vote.update({
            "up": (up + 1),
          });
        } else {
          var down = _checkData["down"];
          await vote.update({"down": (down - 1)});
        }
      }
    } else {
      await _ref.child("comments/$bookId").child("votes").set({"up": 0, "down": 0});
      giveVote(bookId, isUp, isVotedAlready);
    }
  }

  Future<Map<String, dynamic>?> getVoteData(String? bookID) async {
    final snapshot = await _ref.child("comments/$bookID/votes").get();
    if (snapshot.exists) {
      final _data = jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      return _data;
    } else {
      return null;
    }
  }

  // List<CommentModelFromRTD> _list = [];
  // if (snapshot.exists) {
  //   final _data = jsonDecode(jsonEncode(snapshot.value));

  //   for (Map<String, dynamic> item in _data.values) {
  //     for (Map<String, dynamic> listofMaps in item.values) {
  //       _list.add(CommentModelFromRTD.fromMap(listofMaps));
  //     }
  //   }
  //   return _list;
  // } else {
  //   return _list;
  // }

  ///Write data to categories section
  Future<void> writeCategoriesData(Items? items, User? currentUser) async {
    final _date = DateTime.now();

    final _comment =
        _ref.child("categories/${_date.year}/${_date.month}/${items?.volumeInfo?.categories?.first}");
    final _isLiked = await checkUserLikedAlready(items?.id ?? "");
    if (_isLiked == false) {
      await _comment.push().set({
        "likedBy": currentUser?.uid,
        "bookId": items?.id,
      });
    }
  }

  Future<bool> checkUserLikedAlready(String bookId) async {
    final _snapshot =
        await _ref.child("categories/${DateTime.now().year}/${DateTime.now().month}/Fiction/").get();
    if (_snapshot.exists) {
      final _data = jsonDecode(jsonEncode(_snapshot.value));

      List<CategoriesLikedModel>? _modelList = [];

      for (Map<String, dynamic> item in _data.values) {
        _modelList.add(CategoriesLikedModel.fromJson(item));
      }
      if (_modelList.isNotEmpty) {
        for (CategoriesLikedModel item in _modelList) {
          if (item.bookId == bookId) {
            if (item.likedBy == FirebaseAuth.instance.currentUser?.uid) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  // _showSnackMessage(BuildContext context, String data) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  // }
}
