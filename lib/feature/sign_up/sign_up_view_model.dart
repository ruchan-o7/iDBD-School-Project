import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_project_ibdb/core/network/network_manager.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';
import 'package:school_project_ibdb/product/random_pic_generator/random_pict_generator.dart';

import '../../product/utils/firebase/firebase_auth.dart';
import '../../product/utils/firebase/firestore_func.dart';
import 'model/signup_model.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Authentication authentication = Authentication();

  final FocusNode nodeMail = FocusNode();
  final FocusNode nodePass = FocusNode();
  final FocusNode nodePassSecond = FocusNode();
  final FocusNode nodeUserName = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordSecondController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final FirestoreFunctions databaseFuncs = FirestoreFunctions();
  XFile? imagePath;
  XFile? selectedImage;
  String? imageName;

  bool isPressed = false;

  void looseFocus() {
    nodeMail.unfocus();
    nodePass.unfocus();
    nodePassSecond.unfocus();
    nodeUserName.unfocus();
  }

  Future saveUSER(BuildContext context) async {
    looseFocus();
    if (passController.text != passwordSecondController.text) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("passwords are not same")));
    }
    isPressed = !isPressed;
    final photo = await GenerateRandomProfilePic().generateRandomPic();
    final _tempModel = UserSignUpModel(
      likedBooks: [],
      ownedBooks: [],
      imageUrl: photo,
      signDate: DateTime.now().toIso8601String(),
      userMail: mailController.text,
      userName: userNameController.text,
      userPassword: passController.text,
      userUid: "",
    );
    await authentication.signUp(_tempModel, context);
    isPressed = !isPressed;
    Navigator.pop(context);
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class ImageSelected extends SignUpState {}
