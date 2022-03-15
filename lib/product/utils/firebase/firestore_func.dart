import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunctions {
  final database = FirebaseFirestore.instance;
  Future<void> addUserWithSet(
      String name, String e_mail, String password) async {
    await database
        .collection("users")
        .doc()
        .set({"user_name": name, "e-mail": e_mail, "password": password});
  }
}
