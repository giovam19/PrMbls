import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import 'package:pr_mbls/Pages/MainPage.dart';
import 'package:pr_mbls/Styles/Constants.dart';
import 'dart:io';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/widgets.dart';


import '../Models/Media.dart';
import '../Models/Post.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {

  String searchQuery = '';
  bool showSongDescription = false;
  Media? media;
  bool selectedContentType = false;


  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      List<Media> searchResults = await APIManager().search(query);
      if (searchResults.isNotEmpty) {
        setState(() {
          media = searchResults.first;
          showSongDescription = true;
        });
      } else {
        setState(() {
          media = null;
          showSongDescription = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              selectContent(),
              songSearch(),
              Visibility(
                visible: showSongDescription && media != null,
                child: media != null ? songDescription(media!) : Container(),
              ),
              video(),
              postVideo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(Constants.lighgray),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          onChanged: (value) {
            setState(() {
              APIManager().onChangeType(value!);
              selectedContentType = true;
            });
          },
          items: const [
            DropdownMenuItem(
              value: 'Music',
              child: Text('Music'),
            ),
            DropdownMenuItem(
              value: 'Movie',
              child: Text('Movie'),
            ),
          ],
          hint: const Text('Select a field'),
        ),
      ),
    );
  }



  Widget songSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                searchQuery = value;
              });
            }
          },
          onSubmitted: (value) {
            if (value.isNotEmpty && selectedContentType == true) {
              _performSearch(value);
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black45),
            filled: true,
            fillColor: Color(Constants.lighgray),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (searchQuery.isNotEmpty && selectedContentType == true) {
                  _performSearch(searchQuery);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('No Value Provided'),
                      content: Text('Please enter a search query and select a content type.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          if (pattern.isEmpty) {
            return <dynamic>[];
          }
          return await APIManager().search(pattern);
        },

        itemBuilder: (context, suggestion) {
          if (suggestion.name != null && suggestion.name.isNotEmpty) {
            return ListTile(
              title: Text(suggestion.name),
            );
          } else {
            // Return an empty container or any other widget when the suggestion value is empty or an empty string.
            return Container();
          }
        },
        onSuggestionSelected: (suggestion) {
          searchQuery = suggestion.name;
          _performSearch(searchQuery);
        },
      ),
    );
  }


  Widget search() {
    return TextButton(
        onPressed: () {
          if (searchQuery.isNotEmpty) {
            _performSearch(searchQuery);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: const Text(
            "Search",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        )
    );
  }

  Widget songDescription(Media media) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            alignment: Alignment.center,
            child: Image(
              image: Image.network(media.image).image,
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    media.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(Constants.lighgray),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    media.artist,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(Constants.lighgray),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }





  Widget postVideo() {
    return TextButton(
      onPressed: () {
        Post post = Post(
          LoginUser.instance.username!,
          LoginUser.instance.onlineImage!,
          widget.picture.path,
          media?.name ?? '',
          media?.artist ?? '',
          media?.image ?? '',
          DateTime.now(),
          media?.extraInfo ?? '',
          media?.type ?? '',
          media?.year ?? ''
        );
        DataManager().addPost(post);
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(Constants.lightblue),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        child: const Text(
          "Post",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }


  Widget video() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 135),
      child: Center(
        child: Image.file(File(widget.picture.path)),
      ),
    );
  }
}