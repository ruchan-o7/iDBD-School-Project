// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ibdb/core/theme/app_theme.dart';
import 'package:school_project_ibdb/feature/change_password_view/change_pass_view.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';

import 'feature/book_detail/book_detail_view.dart';
import 'feature/editor_view/editor_view.dart';
import 'feature/home_view/home_view.dart';
import 'feature/nav_bar/nav_bar_view.dart';
import 'feature/statistic_view/statistic_view.dart';
import 'product/bookingto_firebase/fire_book_view.dart';

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
      home: FireBookView(),
    );
  }
}

Future<void> init() async {}
