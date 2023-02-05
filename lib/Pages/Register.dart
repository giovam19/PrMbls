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
