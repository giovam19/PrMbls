import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_mbls/Managers/AuthManager.dart';
import 'package:pr_mbls/Pages/CameraPage.dart';
import 'package:pr_mbls/Pages/Register.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../Pages/MainPage.dart';
import '../Pages/NewPublish.dart';

class CustomButtons {

  /*----------------------------------- Buttons ----------------------------------------------*/
  Widget loginButton(CustomTextFields fields, BuildContext context) {
    return TextButton(
      onPressed: () => makeLogin(fields, context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    );
  }

  Widget registerButton(CustomTextFields fields, BuildContext context) {
    return TextButton(
      onPressed: () => makeRegister(fields, context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    );
  }

  Widget signUpButton(BuildContext context) {
    return TextButton(
      onPressed: () => goToSignUp(context),
      child: Text("Sign Up", style: TextStyle(color: Colors.grey))
    );
  }

  Widget backButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
      child: TextButton(
        onPressed: () => returnPage(context),
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget profileButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToProfile(context),
        child: const Icon(Icons.person, size: 40, color: Colors.white),
      ),
    );
  }

  Widget addPublishButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToNewPublish(context),
        child: const Icon(Icons.add_circle_outline, size: 40, color: Colors.white),
      ),
    );
  }

  Widget settingsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: TextButton(
        onPressed: () => goToSettings(context),
        child: const Icon(Icons.settings, size: 40, color: Colors.white),
      ),
    );
  }

  /*----------------------------------- Actions ----------------------------------------------*/
  Future<void> makeLogin(CustomTextFields fields, BuildContext context) async {
    String email = fields.emailText;
    String pass = fields.passText;

    User? user = await AuthManager.signInUsingEmailPassword(email: email, password: pass);

    if (user != null) {
      //Fluttertoast.showToast(msg: "Successful, $email!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
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
      Fluttertoast.showToast(msg: "Wrong", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }
  }

  void goToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }

  void goToProfile(BuildContext context) {
    Fluttertoast.showToast(msg: "Profile", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
  }

  Future<void> goToNewPublish(BuildContext context) async {
    Fluttertoast.showToast(msg: "New Publish", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    await availableCameras()
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));

  }

  void goToSettings(BuildContext context) {
    Fluttertoast.showToast(msg: "Settings", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
  }

  void returnPage(BuildContext context) {
    Navigator.pop(context);
  }

}
