import 'package:flutter/material.dart';
import 'CustomButtons.dart';

class CustomTexts {
  CustomButtons buttons = CustomButtons();

  Widget BigAppName(double top) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, top, 12, 12),
      child: Text(
        "AppName",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't have an account?", style: TextStyle(color: Colors.white)),
          buttons.signUpButton(context),
        ],
      ),
    );
  }
}
