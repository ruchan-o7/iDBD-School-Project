import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';
part 'editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required this.userNameController}) : super(EditProfileInitial());

  final TextEditingController userNameController;
  final FirestoreFunctions _functions = FirestoreFunctions();

  selectImageFromGallery(BuildContext context) async {
    _functions.uploadFromGalleryImage(context, FirebaseAuth.instance.currentUser);
    emit(ImageUploading());
    await Future.delayed(const Duration(seconds: 2), () {
      emit(ImageUploaded());
    });
  }
}
