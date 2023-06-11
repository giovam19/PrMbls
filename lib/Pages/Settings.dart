import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_mbls/Styles/Constants.dart';

import '../GlobalWidgets/CustomButtons.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../GlobalWidgets/CustomTexts.dart';

class Settings extends StatelessWidget {
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
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: textFields.userNameField(),
            ),
            buttons.changeUsernameButton(textFields, context),
            buttons.signOffButton(context),
          ],
        ),
      ),
    );
  }

}