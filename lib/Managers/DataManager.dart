import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Post.dart';

class DataManager {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    QuerySnapshot snapshot = await db.collection("Posts").get();

    for (var p in snapshot.docs) {
      var ob = p.data() as Map<String, dynamic>;
      posts.add(Post.cast(ob));
    }

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }

  Future<void> addPost(Post post) async {
    await db.collection("Posts").add(post.mapPost());
  }
}