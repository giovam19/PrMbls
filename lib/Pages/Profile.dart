import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr_mbls/GlobalWidgets/CustomButtons.dart';
import 'package:pr_mbls/GlobalWidgets/CustomLists.dart';
import 'package:http/http.dart' as http;
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import 'package:pr_mbls/Models/Media.dart';
import 'package:pr_mbls/Models/Post.dart';
import '../GlobalWidgets/CustomTexts.dart';
import '../Styles/Constants.dart';

class Profile extends StatelessWidget {
  CustomTexts texts = CustomTexts();
  CustomButtons buttons = CustomButtons();
  DataManager data = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            LoginUser.instance.onlineImage != null ?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Image.network(LoginUser.instance.onlineImage!, width: 280),
            ) :
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Image.network("https://ideastest.org.uk/wp-content/uploads/2019/04/default-avatar-1.jpg", width: 280),
            ),
          ]
        )
      ),
    );
  }

}