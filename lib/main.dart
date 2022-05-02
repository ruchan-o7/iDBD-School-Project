// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/theme/app_theme.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';
import 'package:school_project_ibdb/feature/nav_bar/nav_bar_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.createThemeData(AppThemeLight()),
      title: 'Ibdb',
      home: FirebaseAuth.instance.currentUser != null ? NavBar() : LoginCardView(),
    );
  }
}

Future<void> init() async {}
