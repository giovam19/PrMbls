import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String username;
  late String userprofile;
  late String postmedia;
  late String titlemedia;
  late String artistmedia;
  late String imagemedia;
  late DateTime timestamp;
  late String extraInfo;
  late String type;
  late String yearmedia;

  Post(this.username, this.userprofile, this.postmedia, this.titlemedia, this.artistmedia,
      this.imagemedia, this.timestamp, this.extraInfo, this.type, this.yearmedia);

  Post.cast(Map<String, dynamic> map) {
    username = map['username'];
    userprofile = map['userprofile'];
    postmedia = map['postmedia'];
    titlemedia = map['titlemedia'];
    artistmedia = map['artistmedia'];
    imagemedia = map['imagemedia'];
    extraInfo = map['extraInfo'];
    type = map['type'];
    yearmedia = map['yearmedia'];

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
      "extraInfo": extraInfo,
      "type": type,
      "yearmedia": yearmedia,
      "timestamp": Timestamp.fromDate(timestamp)
    };
  }
}
