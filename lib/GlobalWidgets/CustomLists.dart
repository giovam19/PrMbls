import 'package:flutter/material.dart';
import 'package:pr_mbls/GlobalWidgets/CustomTexts.dart';

class CustomLists {
  CustomTexts texts = CustomTexts();

  Widget mainList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      itemCount: 18,
      itemBuilder: (BuildContext context, int index) {
        return newPost(index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 20),
    );
  }

  Widget newPost(int index) {
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
                texts.postTexts("Profile ${index}", Colors.black, 14),
              ],
            ),
          ),
          Image(
            image: Image.network("https://www.chanchao.com.tw/images/default.jpg").image
          ),
          Container(
            color: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 6, 6, 6),
                  child: Image(image: Image.network("https://ideastest.org.uk/wp-content/uploads/2019/04/default-avatar-1.jpg").image, height: 50, width: 50),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts.postTexts("Song", Colors.black, 20),
                    texts.postTexts("Artist", Colors.black, 14),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}