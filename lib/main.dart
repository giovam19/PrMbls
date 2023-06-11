import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr_mbls/Pages/MainPage.dart';
import 'package:pr_mbls/Pages/MediaInfo.dart';
import 'Pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Pages/Profile.dart';
import 'Pages/Register.dart';
import 'Styles/Constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RealVibes",
      home: Login(),
      routes: {
        '/main': (context) => MainPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
