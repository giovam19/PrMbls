import 'package:flutter/material.dart';

import '../Models/Post.dart';

class CustomGrid {
  Widget profileGrid(List<Post> data) {
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.transparent,
          child: Center(
            child: data.elementAt(index).postmedia == "" ?
            Image.asset("assets/img/defaultPost.jpg") :
            Image.network(data.elementAt(index).postmedia)
          ),
        );
      },
    );
  }
}