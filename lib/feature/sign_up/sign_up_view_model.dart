import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  String? uploadPath;
  Uint8List? image;
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
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("passwords are not same")));
    }
    isPressed = !isPressed;
    final _tempModel = UserSignUpModel(
      likedBooks: [],
      ownedBooks: [],
      imageUrl: uploadPath ?? "",
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

  void selectImage() async {
    final XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imagePath = selectedImage;
      imageName = selectedImage.name.toString();
    }

    // imagePath = await ImagePicker().pickImage(source: ImageSource.gallery);

    File imageFile = File(selectedImage!.path);
    Uint8List imageRaw = await imageFile.readAsBytes();
    image = imageRaw;
    emit(ImageSelected());
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class ImageSelected extends SignUpState {}
