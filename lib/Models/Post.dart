import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String username;
  late String userprofile;
  late String postmedia;
  late String titlemedia;
  late String artistmedia;
  late String imagemedia;
  late DateTime timestamp;

  Post(this.username, this.userprofile, this.postmedia, this.titlemedia,
      this.artistmedia, this.imagemedia, this.timestamp);

  Post.cast(Map<String, dynamic> map) {
    username = map['username'];
    userprofile = map['userprofile'];
    postmedia = map['postmedia'];
    titlemedia = map['titlemedia'];
    artistmedia = map['artistmedia'];
    imagemedia = map['imagemedia'];

    var micro = map['timestamp'] as Timestamp;
    timestamp = DateTime.fromMicrosecondsSinceEpoch(micro.microsecondsSinceEpoch);
  }

  void printar() {
    print('Media:\n'
        'name: $username\n'
        'title: $titlemedia\n'
        'artist: $artistmedia\n'
        'date: $timestamp\n'
        '-------------------------------');
  }

  Map<String, dynamic> mapPost() {
    return {
      "username": username,
      "userprofile": userprofile,
      "postmedia": postmedia,
      "titlemedia": titlemedia,
      "artistmedia": artistmedia,
      "imagemedia": imagemedia,
      "timestamp": Timestamp.fromDate(timestamp)
    };
  }
}
