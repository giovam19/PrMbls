class Media {
  String name;
  String artist;
  String year;
  String extraInfo;
  String type;
  late String image;

  Media(this.name, this.artist, this.year, this.extraInfo, this.type, this.image);

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