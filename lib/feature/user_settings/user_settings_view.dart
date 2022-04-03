import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../product/utils/firebase/firestore_func.dart';
import '../change_user_name_view/change_user_name_view.dart';

class UserSettingsView extends StatefulWidget {
  UserSettingsView({Key? key}) : super(key: key);

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  _changePage(BuildContext context, Widget Destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Destination,
        ));
  }

  _changeImage() async {
    await FirestoreFunctions(FirebaseFirestore.instance)
        .uploadFromGalleryImage(context, FirebaseAuth.instance.currentUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          profilePreview(context),
          userNameBTN(context),
          passwordBTN(context),
          mailBTN(context),
          deleteAccountBTN(context),
          helpBTN(context),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text("Settings", style: Theme.of(context).textTheme.headline5),
      elevation: 0,
    );
  }

  ListTile profilePreview(BuildContext context) {
    return ListTile(
      contentPadding: context.paddingLow,
      leading: GestureDetector(
        onTap: () {
          //FirestoreFunctions(FirebaseFirestore.instance).uploadFromGalleryImage(context);
          // _selectImage();
          FirestoreFunctions(FirebaseFirestore.instance)
              .uploadFromGalleryImage(context, FirebaseAuth.instance.currentUser);
        },
        child: CircleAvatar(
          backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
              ? NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}")
              : null,
          radius: context.dynamicHeight(0.05),
          child: FirebaseAuth.instance.currentUser?.photoURL == null
              ? Image.asset("assets/icon/dummy_per.png")
              : null,
        ),
      ),
      title: Text(FirebaseAuth.instance.currentUser?.displayName ?? "Null user name"),
      subtitle: Text(FirebaseAuth.instance.currentUser?.email ?? "null mail"),
    );
  }

  Widget userNameBTN(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changePage(context, ChangeUserName());
      },
      child: const ListTile(
        leading: Icon(Icons.account_box),
        title: Text("Change user name"),
      ),
    );
  }

  Widget passwordBTN(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.lock),
      title: Text("Change password"),
    );
  }

  Widget mailBTN(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.mail),
      title: Text("Change e-mail"),
    );
  }

  Widget deleteAccountBTN(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.sd_card),
      title: Text("Delete account"),
    );
  }

  Widget helpBTN(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.help),
      title: Text("Help"),
    );
  }
}
