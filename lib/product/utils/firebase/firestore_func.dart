import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_project_ibdb/feature/sign_up/model/signup_model.dart';

abstract class IFirestoreFuncs {
  final FirebaseFirestore instance;

  IFirestoreFuncs(this.instance);
  Future<void> addUserWithSet(String name, String e_mail, String password);
  Future<void> addUserWithSetModel(UserSignUpModel model);
}

class FirestoreFunctions extends IFirestoreFuncs {
  // final database = FirebaseFirestore.instance;

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
}
