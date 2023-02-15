import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/spotify.dart';
import '../Models/Media.dart';

class APIManager {
  static final APIManager _instance = APIManager._internal();

  String url = "";
  String type = "Movie";
  late SpotifyApi spotify;

  final String movieDomain = "https://www.omdbapi.com/?";
  final String moviesKey = "&apikey=4c3d7a45";
  String moviesParams = "type=movie&s=";
  String specificParams = "i=";
  String seriesParams = "type=series&s=";

  final String musicClientId = "955a9f52efa34079abb62ba64d1330b0";
  final String musicClientSecret = "8a7a28b3056647a98d42a78dc91d1943";

  late List<Media> list;

  factory APIManager() {
    return _instance;
  }

  APIManager._internal() {
    final credentials = SpotifyApiCredentials(musicClientId, musicClientSecret);
    spotify = SpotifyApi(credentials);
  }

  void onChangeType(String type) {
    this.type = type;
  }

  Future<List<Media>> search(String search) async {
    switch(type) {
      case "Movie":
        url = "$movieDomain$moviesParams$search$moviesKey";
        list = await _searchMovie();
        return list;

      case "Series":
        url = "$movieDomain$seriesParams$search$moviesKey";
        list = await _searchMovie();
        return list;

      case "Music":
        list = await _searchMusic(search);
        return list;

      default:
        return [];
    }
  }

  Future<List<Media>> _searchMovie() async {
    final response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    //parse
    List<Media> medias = [];
    for (var item in data["Search"]) {
      var url = movieDomain + specificParams + item["imdbID"] + moviesKey;
      final response = await http.get(Uri.parse(url));
      var aux = json.decode(response.body);

      var param = type == "Movie" ? aux["Director"] : aux["Writer"];

      Media media = Media(aux["Title"], param, aux["Year"], aux["Genre"], type);
      media.buildImage(aux["Poster"]);
      medias.add(media);
    }

    return medias;
  }

  Future<List<Media>> _searchMusic(String search) async {
    var result = await spotify.search.get(search).first();
    result.removeAt(4); //eliminar la 4 por bu del sdk

    List<Media> medias = [];
    for (var pages in result) {
      for (var item in pages.items!) {
        if (item is TrackSimple) {
          var track = await spotify.tracks.get(item.id!);
          Media media = Media(track.name!, track.artists!.first.name!, track.album!.releaseDate!, track.album!.name!, type);
          media.buildImage(track.album!.images!.first.url!);
          medias.add(media);
        }
      }
    }

    return medias;
  }
}
