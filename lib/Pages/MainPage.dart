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


class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CustomTexts texts = CustomTexts();

  CustomLists lists = CustomLists();

  CustomButtons buttons = CustomButtons();

  DataManager data = DataManager();

  List<Post> posts = [];


 // Declare a variable to store fetched posts
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: RefreshIndicator(
        onRefresh: () => data.getPosts(), // Specify the function to call when refreshing
        child: FutureBuilder(
          future: data.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              posts = snapshot.data!; // Assign the fetched posts to the posts variable
              return body(context);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(Constants.lighgray)),
                  ],
                ),
              );
            }
          },
        ),

      ),
    );
  }

  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              texts.MediumAppName(50, 24),
              Spacer(),
              buttons.profileButton(context),
            ],
          ),
          Expanded(
            flex: MediaQuery.of(context).size.height.round(),
            child: RefreshIndicator(
              onRefresh: () async {
                List<Post> refreshedPosts = await data.getPosts(); // Fetch new posts
                setState(() {
                  posts = refreshedPosts; // Update the posts variable
                });
              },
              child: lists.mainList(posts), // Use the updated posts variable
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttons.addPublishButton(context),
            ],
          ),
        ],
      ),
    );
  }

}