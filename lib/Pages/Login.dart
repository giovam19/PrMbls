import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import 'package:pr_mbls/Styles/Constants.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../GlobalWidgets/CustomTexts.dart';
import '../GlobalWidgets/CustomButtons.dart';

class Login extends StatelessWidget {
  CustomTextFields textFields = CustomTextFields();
  CustomTexts texts = CustomTexts();
  CustomButtons buttons = CustomButtons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              texts.BigAppName(60),
              textFields.emailField(),
              textFields.passField(),
              buttons.loginButton(textFields, context),
              texts.signUp(context),
            ]
        ),
      ),
    );
  }

}
