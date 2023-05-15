import 'package:flutter/material.dart';
import 'package:pr_mbls/GlobalWidgets/CustomTexts.dart';
import 'package:pr_mbls/Managers/APIManager.dart';

import '../Models/Post.dart';

class MediaInfo extends StatelessWidget {
  final Post post;
  CustomTexts texts = CustomTexts();
  APIManager api = APIManager();

  MediaInfo({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    texts.extraMedia("Artist: ${post.artistmedia}"),
                    texts.extraMedia("Published: ${post.timestamp}"),
                    texts.extraMedia("Album: hola"),
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