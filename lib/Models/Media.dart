import 'package:flutter/material.dart';

class Media {
  String name;
  String artist;
  String year;
  String extraInfo;
  String type;
  late Image image;

  Media(this.name, this.artist, this.year, this.extraInfo, this.type);

  void buildImage(String data) {
    image = Image.network(data);
  }

  void printMedia() {
    print('Media:\n'
        'name: $name\n'
        'artists: $artist\n'
        'year: $year\n'
        'extra: $extraInfo\n'
        'img: $image\n'
        '-------------------------------');
  }
}