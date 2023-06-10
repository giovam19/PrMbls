import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr_mbls/GlobalWidgets/CustomButtons.dart';
import 'package:pr_mbls/GlobalWidgets/CustomLists.dart';
import 'package:http/http.dart' as http;
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:pr_mbls/Models/Media.dart';
import 'package:pr_mbls/Models/Post.dart';
import '../GlobalWidgets/CustomTexts.dart';
import '../Styles/Constants.dart';

class MainPage extends StatelessWidget {
  CustomTexts texts = CustomTexts();
  CustomLists lists = CustomLists();
  CustomButtons buttons = CustomButtons();
  DataManager data = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: FutureBuilder(
        future: data.getPosts(),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              texts.MediumAppName(50, 24),
            ],
          ),
          Expanded(
            flex: MediaQuery.of(context).size.height.round(),
            child: lists.mainList(data),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buttons.profileButton(context),
              Spacer(),
              buttons.addPublishButton(context),
              Spacer(),
              buttons.settingsButton(context),
            ],
          ),
        ]
      ),
    );
  }

}