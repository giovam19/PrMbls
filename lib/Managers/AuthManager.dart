import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pr_mbls/Pages/Login.dart';
import '../Models/FirebaseUser.dart';
import '../Models/LoginUser.dart';
//apikey = 4c3d7a45 OMDb
class AuthManager {
  static DataManager dataManager = DataManager();

  static Future<User?> registerUsingEmailPassword({required String name, required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
      await user?.updateDisplayName(name);

      if (LoginUser.instance.image != null) {
        dataManager.addProfilePhoto(name, LoginUser.instance.image!);
        print("photo saved");
      }

      if(LoginUser.instance.onlineImage != null) {
        await user?.updatePhotoURL(LoginUser.instance.onlineImage);
        print("photo updated");
      }

      await user?.reload();
      user = auth.currentUser;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  static Future<bool> isLogged() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("email") == null) {
      return false;
    }

    LoginUser.instance.email = preferences.getString("email");
    LoginUser.instance.username = preferences.getString("username");
    LoginUser.instance.onlineImage = preferences.getString("onlineImage");

    return true;
  }


  static Future<User?> signInUsingEmailPassword({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

      LoginUser.instance.email = user?.email;
      LoginUser.instance.username = user?.displayName;
      LoginUser.instance.onlineImage = await dataManager.getProfilePhoto(user!.displayName!);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("email", LoginUser.instance.email!);
      preferences.setString("username", LoginUser.instance.username!);
      preferences.setString("onlineImage", LoginUser.instance.onlineImage!);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      }
    }

    return user;
  }

  static Future<void> signOff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove("email");
    preferences.remove("username");
    preferences.remove("onlineImage");
  }
}
