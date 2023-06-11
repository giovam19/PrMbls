import 'package:flutter/material.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import '../GlobalWidgets/CustomButtons.dart';
import '../GlobalWidgets/CustomTextFields.dart';
import '../GlobalWidgets/CustomTexts.dart';
import '../Styles/Constants.dart';

class Register extends StatelessWidget {
  CustomTextFields textFields = CustomTextFields();
  CustomTexts texts = CustomTexts();
  CustomButtons buttons = CustomButtons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              texts.BigAppName(20),
              textFields.userNameField(),
              textFields.emailField(),
              textFields.passField(),
              if (LoginUser.instance.image != null)
                Image(
                    image: Image.file(LoginUser.instance.image!).image, height: 180, width: 180
                ),
              buttons.addPhoto(context),
              buttons.registerButton(textFields, context),
            ],
          ),
        ),
      ),
    );
  }

}
