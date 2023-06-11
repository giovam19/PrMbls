import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr_mbls/Managers/AuthManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import 'package:pr_mbls/Pages/CameraPage.dart';
import 'package:pr_mbls/Pages/Profile.dart';
import 'package:pr_mbls/Pages/Register.dart';
import 'package:pr_mbls/Pages/Settings.dart';
import 'package:pr_mbls/Styles/Constants.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../Pages/Login.dart';
import '../Pages/MainPage.dart';
import '../Pages/NewPublish.dart';

class CustomButtons {
  DataManager dataManager = DataManager();

  /*----------------------------------- Buttons ----------------------------------------------*/
  Widget loginButton(CustomTextFields fields, BuildContext context) {
    return TextButton(
      onPressed: () => makeLogin(fields, context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(Constants.lightblue).withOpacity(0.81),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          "Login",
          style: TextStyle(color: Color(Constants.lighgray), fontSize: 20),
        ),
      )
    );
  }

  Widget registerButton(CustomTextFields fields, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextButton(
        onPressed: () => makeRegister(fields, context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(Constants.lightblue).withOpacity(0.81),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
          child: Text(
            "Register",
            style: TextStyle(color: Color(Constants.lighgray), fontSize: 20),
          ),
        )
      ),
    );
  }

  Widget addPhoto(BuildContext context) {
    return TextButton(
        onPressed: () => pickImage(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(Constants.lightblue).withOpacity(0.81),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
          child: Text(
            "Pick Image",
            style: TextStyle(color: Color(Constants.lighgray), fontSize: 20),
          ),
        )
    );
  }

  Widget signUpButton(BuildContext context) {
    return TextButton(
      onPressed: () => goToSignUp(context),
      child: Text("Sign Up", style: TextStyle(color: Color(Constants.green)))
    );
  }

  Widget backButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
      child: TextButton(
        onPressed: () => returnPage(context),
        child: Icon(Icons.arrow_back, color: Color(Constants.lighgray)),
      ),
    );
  }

  Widget profileButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToProfile(context),
        child: Icon(Icons.person, size: 40, color: Color(Constants.lighgray)),
      ),
    );
  }

  Widget addPublishButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToNewPublish(context),
        child: Icon(Icons.add_circle_outline, size: 40, color: Color(Constants.lighgray)),
      ),
    );
  }

  Widget settingsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToSettings(context),
        child: Icon(Icons.settings, size: 40, color: Color(Constants.lighgray)),
      ),
    );
  }

  Widget changeUsernameButton(CustomTextFields fields, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: TextButton(
          onPressed: () => changeUsername(fields),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(Constants.lightblue).withOpacity(0.81),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Text(
              "Change Username",
              style: TextStyle(color: Color(Constants.lighgray), fontSize: 20),
            ),
          )
      ),
    );
  }

  Widget signOffButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 84, 0, 0),
      child: TextButton(
          onPressed: () => signOff(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(Constants.lightblue).withOpacity(0.81),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Sign Off",
              style: TextStyle(color: Color(Constants.lighgray), fontSize: 20),
            ),
          )
      ),
    );
  }

  /*----------------------------------- Actions ----------------------------------------------*/
  Future<void> makeLogin(CustomTextFields fields, BuildContext context) async {
    String email = fields.emailText;
    String pass = fields.passText;

    User? user = await AuthManager.signInUsingEmailPassword(email: email, password: pass);

    if (user != null) {
      fields.emailController = "";
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      Fluttertoast.showToast(msg: "Wrong", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }

    fields.passController = "";
  }


  Future<void> makeRegister(CustomTextFields fields, BuildContext context) async {
    String email = fields.emailText;
    String pass = fields.passText;
    String user = fields.userText;

    User? userData = await AuthManager.registerUsingEmailPassword(name: user, email: email, password: pass);

    if (userData != null) {
      Fluttertoast.showToast(msg: "Register Successful", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Register Wrong", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      LoginUser.instance.image = File(picked.path);
      (context as Element).reassemble();
    } else {
      LoginUser.instance.image = null;
    }
  }

  void goToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }

  void goToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }

  Future<void> goToNewPublish(BuildContext context) async {
    await availableCameras()
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));

  }

  void goToSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
  }

  void returnPage(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> changeUsername(CustomTextFields fields) async {
    String user = fields.userText;
    bool res = await dataManager.changeUsername(user);

    if (res) {
      fields.userNameController = "";
      Fluttertoast.showToast(msg: "Username updated!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    } else {
      Fluttertoast.showToast(msg: "Error updating", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }
  }

  void signOff(BuildContext context) {
    AuthManager.signOff();
    /*int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });*/
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
