import 'package:flutter/material.dart';
import 'package:pr_mbls/Styles/Constants.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import '../Models/Post.dart';


class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 80, 20, 10),
        child: Column(
          children: [
            // Display the photo and other information of the post.
            // Customize this section based on your requirements.
            Image.network(post.postmedia),
            songDescription(post),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('yyyy-MM-dd HH:mm').format(post.timestamp),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(Constants.lighgray),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget songDescription(Post post) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
    child: Row(
      children: <Widget>[
        Container(
          width: 140.0,
          height: 140.0,
          alignment: Alignment.center,
          child: Image(
            image: Image.network(post.imagemedia).image,
            height: 120,
            width: 120,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.titlemedia,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(Constants.lighgray),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  post.artistmedia,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(Constants.lighgray),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}