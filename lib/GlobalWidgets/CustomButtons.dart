import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_mbls/Managers/AuthManager.dart';
import 'package:pr_mbls/Pages/Register.dart';
import '../GlobalWidgets/CustomTextFields.dart';

class CustomButtons {

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

  Future<void> makeLogin(CustomTextFields fields, BuildContext context) async {
    String email = fields.emailText;
    String pass = fields.passText;

    User? user = await AuthManager.signInUsingEmailPassword(email: email, password: pass);

    if (user != null) {
      Fluttertoast.showToast(msg: "Successful, $email!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
      fields.emailController = "";
    } else {
      Fluttertoast.showToast(msg: "Wrong", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }

    fields.passController = "";
  }

  void goToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }

  Future<void> makeRegister(CustomTextFields fields, BuildContext context) async {
    String email = fields.emailText;
    String pass = fields.passText;
    String user = fields.userText;

    User? userData = await AuthManager.registerUsingEmailPassword(name: user, email: email, password: pass);

    if (userData != null) {
      Fluttertoast.showToast(msg: "Successful", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    } else {
      Fluttertoast.showToast(msg: "Wrong", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }
  }

  void returnPage(BuildContext context) {
    Navigator.pop(context);
  }

}
