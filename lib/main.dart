import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr_mbls/Managers/AuthManager.dart';
import 'package:pr_mbls/Pages/MainPage.dart';
import 'package:pr_mbls/Pages/Settings.dart';
import 'Pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Pages/Profile.dart';
import 'Pages/Register.dart';
import 'Styles/Constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  bool isLogged = await AuthManager.isLogged();

  runApp(MyApp(isLogged));
}

class MyApp extends StatelessWidget {
  late bool isLogged;

  MyApp(this.isLogged, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RealVibes",
      home: isLogged ? MainPage() : Login(),
      routes: {
        '/login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
