import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr_mbls/GlobalWidgets/CustomButtons.dart';
import 'package:pr_mbls/GlobalWidgets/CustomGrid.dart';
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
  CustomGrid grid = CustomGrid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(Constants.mediumblue),
        body: FutureBuilder(
          future: data.getMyPosts(LoginUser.instance.username!),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return body(context, snapshot.data!);
            } else {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Color(Constants.lighgray))]));
            }
          },
        )
    );
  }

  Widget body(BuildContext context, List<Post> data) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LoginUser.instance.onlineImage != "" ?
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Image.network(LoginUser.instance.onlineImage!, height: 280),
                ) :
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Image.network("https://ideastest.org.uk/wp-content/uploads/2019/04/default-avatar-1.jpg", height: 280),
                ),
                texts.userName(LoginUser.instance.username!),
                Expanded(
                  flex: MediaQuery.of(context).size.height.round(),
                  child: grid.profileGrid(data),
                ),
              ]
          )
      ),
    );
  }
}