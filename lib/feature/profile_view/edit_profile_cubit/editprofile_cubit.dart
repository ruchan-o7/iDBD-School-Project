import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';
import '../../../product/utils/firebase/firebase_auth.dart';
import '../../../product/utils/firebase/firestore_func.dart';
part 'editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required this.userNameController}) : super(EditProfileInitial());

  final TextEditingController userNameController;
  final FirestoreFunctions _functions = FirestoreFunctions();
  final _auth = Authentication();

  selectImageFromGallery(BuildContext context) async {
    //!image upload not yet implemented
    _functions.uploadFromGalleryImage(context, FirebaseAuth.instance.currentUser);
    await Future.delayed(const Duration(seconds: 2), () {
      emit(ImageUploaded());
    });
  }

  Future<void> resetPassword(BuildContext context) async {
    await _auth.resetPassword(FirebaseAuth.instance.currentUser?.email ?? "", context);
    _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginCardView()));
  }
}

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  Future<void> deleteAccount() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser?.delete();
    }
  }
}

abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}
