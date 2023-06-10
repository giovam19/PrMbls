import 'package:flutter/material.dart';
import '../Styles/Constants.dart';
import 'CustomButtons.dart';

class CustomTexts {
  CustomButtons buttons = CustomButtons();

  final String Appname = "RealVibes";

  Widget BigAppName(double top) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, top, 12, 12),
      child: Text(
        Appname,
        style: TextStyle(
          color: Color(Constants.lighgray),
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
          color: Color(Constants.lighgray),
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
          Text("Don't have an account?", style: TextStyle(color: Color(Constants.lighgray))),
          buttons.signUpButton(context),
        ],
      ),
    );
  }

  Widget postTexts(String text, Color color, double size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: size),
      ),
    );
  }

  Widget nameMedia(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Color(Constants.lighgray)),
      ),
    );
  }

  Widget extraMedia(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Color(Constants.lighgray)),
      ),
    );
  }
}
