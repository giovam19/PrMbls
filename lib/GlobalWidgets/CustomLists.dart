import 'package:flutter/material.dart';
import 'package:pr_mbls/GlobalWidgets/CustomTexts.dart';
import 'package:pr_mbls/Models/Post.dart';
import 'package:pr_mbls/Pages/MediaInfo.dart';

import '../Models/Media.dart';

class CustomLists {
  CustomTexts texts = CustomTexts();

  Widget mainList(List<Post> mdata) {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      itemCount: mdata.length,
      itemBuilder: (BuildContext context, int index) {
        return newPost(context, index, mdata,);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 20),
    );
  }

  Widget newPost(BuildContext context, int index, List<Post> data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 6, 6, 6),
                  child: Image(image: Image.network("https://ideastest.org.uk/wp-content/uploads/2019/04/default-avatar-1.jpg").image, height: 40, width: 40),
                ),
                texts.postTexts(data.elementAt(index).username, Colors.black, 14),
              ],
            ),
          ),
          Image(
            image: Image.asset("assets/img/defaultPost.jpg").image
          ),
          Container(
            color: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 6, 6, 6),
                  child: Image( image: data.elementAt(index).imagemedia == "" ?
                      Image.network("https://ideastest.org.uk/wp-content/uploads/2019/04/default-avatar-1.jpg").image :
                      Image.network(data.elementAt(index).imagemedia).image,
                    height: 40,
                    width: 40,
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () => gotoMediaInfo(context, data.elementAt(index)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: texts.postTexts(data.elementAt(index).titlemedia, Colors.black, 20),
                        ),
                        texts.postTexts(data.elementAt(index).artistmedia, Colors.black, 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void gotoMediaInfo(BuildContext context, Post post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MediaInfo(post: post)));
  }
}