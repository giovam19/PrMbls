import 'package:flutter/material.dart';
import 'CustomButtons.dart';

class CustomTexts {
  CustomButtons buttons = CustomButtons();

  final String Appname = "AppName";

  Widget BigAppName(double top) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, top, 12, 12),
      child: Text(
        Appname,
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget MediumAppName(double top, double left) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, 12, 12),
      child: Text(
        Appname,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
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

  Widget postTexts(String text, Color color, double size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
      child: Text(
          text,
          style: TextStyle(color: color, fontSize: size)
      ),
    );
  }

}
