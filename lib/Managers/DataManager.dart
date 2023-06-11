import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import '../Models/Post.dart';

class DataManager {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Post>> getPosts(String username) async {
    List<Post> posts = [];
    QuerySnapshot snapshot = await db.collection("Posts").get();

    for (var p in snapshot.docs) {
      var ob = p.data() as Map<String, dynamic>;
      Post data = Post.cast(ob);
      if (data.username != username) {
        posts.add(data);
      }
    }

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }

  Future<List<Post>> getMyPosts(String username) async {
    List<Post> posts = [];
    QuerySnapshot snapshot = await db.collection("Posts").get();

    for (var p in snapshot.docs) {
      var ob = p.data() as Map<String, dynamic>;
      Post data = Post.cast(ob);
      if (data.username == username) {
        posts.add(data);
      }
    }

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }

  Future<void> addPost(Post post) async {
    addPostPhoto(post);
  }
  
  Future<void> addProfilePhoto(String filename, File file) async {
    String path = "profile_photos/$filename";
    var snapshot = await storage.ref().child(path).putFile(file).then((p0) async => {
      LoginUser.instance.onlineImage = await p0.ref.getDownloadURL()
    });
  }

  Future<void> addPostPhoto(Post post) async {
    String filename = post.username+post.timestamp.toString();
    File file = File(post.postmedia);
    String url;
    String path = "post_photos/$filename";

    var snapshot = await storage.ref().child(path).putFile(file).then((p0) async => {
      url = await p0.ref.getDownloadURL(),
      post.postmedia = url,
      await db.collection("Posts").add(post.mapPost())
    });
  }

  Future<String> getProfilePhoto(String filename) async {
    String url;
    try {
      String path = "profile_photos/$filename";
      url = await storage.ref().child(path).getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        url = "";
      } else {
        url = "";
      }
    }

    return url;
  }

  Future<bool> changeUsername(String username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(username);
      changePostsUser(username);

      return true;
    }

    return false;
  }
  
  Future<void> changePostsUser(String username) async {
    QuerySnapshot snapshot = await db.collection("Posts").get();

    for (var p in snapshot.docs) {
      var ob = p.data() as Map<String, dynamic>;
      if (ob['username'] == LoginUser.instance.username) {
        p.reference.update({
          'username': username
        });
      }
    }

    LoginUser.instance.username = username;
  }
}