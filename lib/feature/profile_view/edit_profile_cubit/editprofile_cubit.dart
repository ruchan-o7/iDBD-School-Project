import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required this.userNameController}) : super(EditProfileInitial());

  final TextEditingController userNameController;

  selectImageFromGallery() {
    print("object");
  }
}
