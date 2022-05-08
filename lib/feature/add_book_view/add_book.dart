import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/border_radius.dart';
import 'package:school_project_ibdb/feature/add_book_view/cubit/addbook_cubit.dart';
import 'package:school_project_ibdb/product/book_categories/categories.dart';
import 'package:school_project_ibdb/product/utils/validator/validator.dart';

class AddBookView extends StatelessWidget {
  AddBookView({Key? key}) : super(key: key);

  String publishDate = "";
  //Todo: generate book id 12 letter,
  //Todo:

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddbookCubit(),
      child: BlocConsumer<AddbookCubit, AddbookState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("Add book"),
            ),
            body: GestureDetector(
              onTap: context.read<AddbookCubit>().looseFocus,
              child: SingleChildScrollView(
                child: Padding(
                  padding: context.paddingLow,
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: context.read<AddbookCubit>().formKey,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              pickImage(context, state),
                              const VerticalDivider(),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    bookNameCard(context),
                                    const Divider(),
                                    autohorName(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          categories(context),
                          Card(
                              child: ListTile(
                            leading: const Text("Publish Date"),
                            title: TextFormField(
                              validator: (value) => Validator().validateName(name: value),
                              focusNode: context.read<AddbookCubit>().publishDateNode,
                              controller: context.read<AddbookCubit>().publishDateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        final date = await showDatePicker(
                                            currentDate: DateTime.now(),
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(0),
                                            lastDate: DateTime.now());
                                        publishDate = "${date?.day}/${date?.month}/${date?.year}";
                                        context.read<AddbookCubit>().changeDateTime(publishDate);
                                      },
                                      icon: const Icon(Icons.calendar_month))),
                            ),
                          )),
                          pageCount(context),
                          description(context),
                        ],
                      )),
                ),
              ),
            ),
            floatingActionButton: fab(context),
          );
        },
      ),
    );
  }

  Expanded pickImage(BuildContext context, AddbookState state) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () async {
          // bool? _temp;
          bool? _isCamera = await showModalBottomSheet<bool>(
            enableDrag: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => pickImageOptionsSheet(context),
          );
          context.read<AddbookCubit>().addImage(_isCamera);
        },
        child: Container(
            height: context.dynamicHeight(0.20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadiusConst.normal,
            ),
            child: context.read<AddbookCubit>().isImageSelected
                ? Container(
                    margin: context.paddingLow,
                    child: ClipRRect(
                      borderRadius: BorderRadiusConst.normal,
                      child: Image.file(
                        File(context.read<AddbookCubit>().selectedImage?.path ?? ""),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : const Icon(Icons.add_a_photo)),
      ),
    );
  }

  Card bookNameCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
      child: TextFormField(
          validator: (value) => Validator().validateName(name: value),
          focusNode: context.read<AddbookCubit>().bNameNode,
          controller: context.read<AddbookCubit>().bNameController,
          decoration: const InputDecoration(hintText: "Book name")),
    );
  }

  Card autohorName(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
        child: TextFormField(
            validator: (value) => Validator().validateName(name: value),
            focusNode: context.read<AddbookCubit>().aNameNode,
            controller: context.read<AddbookCubit>().aNameController,
            decoration: const InputDecoration(hintText: "Author name")));
  }

  Card categories(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Text("Categories"),
        title: DropdownButton(
          borderRadius: BorderRadiusConst.normal,

          onChanged: ((String? value) {
            context.read<AddbookCubit>().changeCategories(value);
          }), //Todo:function implement
          value: context.read<AddbookCubit>().dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          items: Categories.instance.getCategorieList
              ?.map((String value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Card pageCount(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Text("Page Count"),
      title: TextFormField(
        validator: (value) => Validator().validateName(name: value),
        focusNode: context.read<AddbookCubit>().pageCountNode,
        controller: context.read<AddbookCubit>().pageCountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(),
      ),
    ));
  }

  Card description(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
        child: TextFormField(
          validator: (value) => Validator().validateName(name: value),
          focusNode: context.read<AddbookCubit>().descNode,
          controller: context.read<AddbookCubit>().descController,
          maxLines: 18,
          decoration: const InputDecoration(hintText: "Description"),
        ));
  }

  FloatingActionButton fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<AddbookCubit>().checkValidate(context);
      },
      child: const Icon(Icons.done),
    );
  }

  Widget pickImageOptionsSheet(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.25),
      width: context.dynamicWidth(0.9),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // isCamera = true;
              Navigator.pop(context, true);
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.camera),
                title: Text("Pick from camera", style: Theme.of(context).textTheme.headline5),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
              // isCamera = false;
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text("Pick from gallery", style: Theme.of(context).textTheme.headline5),
              ),
            ),
          ),
          Card(
            child: ListTile(
                title: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.headline5,
                    ))),
          )
        ],
      ),
    );
  }
}
