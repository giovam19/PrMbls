import 'package:flutter/material.dart';
import 'package:pr_mbls/GlobalWidgets/CustomTexts.dart';
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:intl/intl.dart';

import '../Models/Post.dart';
import '../Styles/Constants.dart';

class MediaInfo extends StatelessWidget {
  final Post post;
  CustomTexts texts = CustomTexts();
  APIManager api = APIManager();

  MediaInfo({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Image.network(post.imagemedia, width: 280),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts.nameMedia("${post.titlemedia}"),
                    post.type == "Music" ?
                    texts.extraMedia("Artist: ${post.artistmedia}") :
                    texts.extraMedia("Director: ${post.artistmedia}"),
                    texts.extraMedia("Published: ${post.yearmedia}"),
                    post.type == "Music" ?
                    texts.extraMedia("Album: ${post.extraInfo}") :
                    texts.extraMedia("Genre: ${post.extraInfo}")
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }

}