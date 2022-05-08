import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_project_ibdb/feature/add_book_view/model.dart';
import 'package:school_project_ibdb/feature/profile_view/cubit/profileview_cubit.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';
import 'package:school_project_ibdb/product/book_categories/categories.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

part 'addbook_state.dart';

class AddbookCubit extends Cubit<AddbookState> {
  AddbookCubit() : super(AddbookInitial()) {
    init();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bNameController = TextEditingController();
  final aNameController = TextEditingController();
  final publishDateController = TextEditingController();
  final pageCountController = TextEditingController();
  final descController = TextEditingController();

  final bNameNode = FocusNode();
  final aNameNode = FocusNode();
  final publishDateNode = FocusNode();
  final pageCountNode = FocusNode();
  final descNode = FocusNode();

  String? dropdownValue = Categories.instance.getCategorieList?.first;
  String publishDate = "06/03/2000";
  String? bookImageUrl;
  XFile? selectedImage;
  bool isImageSelected = false;

  late String bookId;
  bool? isCamera;

  final FirestoreFunctions _functions = FirestoreFunctions();

  init() {
    bookId = getRandomString(12);
  }

  void looseFocus() {
    bNameNode.unfocus();
    aNameNode.unfocus();
    publishDateNode.unfocus();
    pageCountNode.unfocus();
    pageCountNode.unfocus();
    descNode.unfocus();
  }

  changeDateTime(String newDate) {
    publishDate = newDate;
    publishDateController.text = publishDate;
    emit(RefreshPage());
  }

  Future<void> addImage(bool? isCamera) async {
    if (isCamera == null) return;
    if (isCamera) {
      selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImage == null) return;

      bookImageUrl = await _functions.uploadImage(selectedImage, bookId);
      isImageSelected = true;
      emit(RefreshPage());
    } else {
      selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) return;
      bookImageUrl = await _functions.uploadImage(selectedImage, bookId); //!
      isImageSelected = true;
      emit(RefreshPage());
    }
  }

  changeCategories(String? val) {
    dropdownValue = val;
    emit(RefreshPage());
  }

  void checkValidate(BuildContext context) {
    if (!checkTexts()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill empty areas")));
    } else {
      _functions.addBookRequest(BookRequestModel(
          id: bookId,
          volumeInfo: VolumeInfo(
              authors: [aNameController.text],
              categories: [dropdownValue ?? "Uncategorized"],
              description: descController.text,
              imageLinks: ImageLinks(thumbnail: bookImageUrl),
              pageCount: int.parse(pageCountController.text),
              publishedDate: publishDate,
              title: bNameController.text)));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: Theme.of(context).textTheme.button,
                      ))
                ],
                title: Center(
                  child: Text("Request sent succesfuly"),
                ),
              ));
    }
  }

  bool checkTexts() {
    if (bNameController.text == "") return false;
    if (aNameController.text == "") return false;
    if (publishDateController.text == "") return false;
    if (pageCountController.text == "") return false;
    if (descController.text == "") return false;
    return true;
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  isRamFree() async {
    if (selectedImage?.readAsBytes() == null) {
      return true;
    }
    return false;
  }
}
