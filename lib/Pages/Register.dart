import 'package:flutter/material.dart';
import '../GlobalWidgets/CustomButtons.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../GlobalWidgets/CustomTexts.dart';

class Register extends StatelessWidget {
  CustomTextFields textFields = CustomTextFields();
  CustomTexts texts = CustomTexts();
  CustomButtons buttons = CustomButtons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  buttons.backButton(context)
                ],
              ),
              texts.BigAppName(20),
              textFields.userNameField(),
              textFields.emailField(),
              textFields.passField(),
              buttons.registerButton(textFields, context),
            ],
        ),
      ),
    );
  }

}

/*
* Padding(
        padding: EdgeInsets.fromLTRB(24, 60, 24, 12),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buttons.backButton(context)
                    ],
                ),
                texts.BigAppName(),
                SizedBox(height: 48),
                textFields.userNameField(),
                SizedBox(height: 24),
                textFields.emailField(),
                SizedBox(height: 24),
                textFields.passField(),
                SizedBox(height: 24),
                buttons.registerButton(textFields, context),
              ]
          ),
        ),
      ),
* */