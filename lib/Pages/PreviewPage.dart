import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
import 'package:pr_mbls/Models/LoginUser.dart';
import 'package:pr_mbls/Pages/MainPage.dart';
import 'package:pr_mbls/Styles/Constants.dart';
import 'dart:io';
import 'package:flutter_typeahead/flutter_typeahead.dart';


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

  void _performSearch(String query) async {
    List<Media> searchResults = await APIManager().search(query);
    if (searchResults.isNotEmpty) {
      setState(() {
        media = searchResults.first;
        showSongDescription = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Results'),
            content: const Text('No search results found.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.mediumblue),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 50), // Set the desired margin value
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              musicSearch(),
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

  Widget musicSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(Constants.lighgray), // Add your desired background color here
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none, // Remove the border
            contentPadding: EdgeInsets.symmetric(horizontal: 16), // Adjust the content padding
          ),
          onChanged: (value) {
            setState(() {
              APIManager().onChangeType(value!);
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
          hint: const Text('Select a field'), // Add a hint text
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
            setState(() {
              searchQuery = value;
            });
          },
          onSubmitted: (value) {
            _performSearch(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black45),
            filled: true,
            fillColor: Color(Constants.lighgray), // Add your desired background color here
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _performSearch(searchQuery);
              },
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          // Implement your song search logic here, returning a list of suggestions
          return await APIManager().search(pattern);
        },
        itemBuilder: (context, suggestion) {
          // Customize the appearance of each suggestion item in the dropdown
          return ListTile(
            title: Text(suggestion.name),
          );
        },
        onSuggestionSelected: (suggestion) {
          // Handle the selection of a suggestion from the dropdown
          searchQuery = suggestion.name;
          _performSearch(searchQuery);
        },
      ),
    );
  }


  Widget search() {
    return TextButton(
        onPressed: () {
          _performSearch(searchQuery);
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
            // color: Colors.blue, // Uncomment this line if you want a background color for the container
            alignment: Alignment.center,
            child: Image(
                image: Image.network(media.image).image,
                height: 100,
                width: 100
            ),
          ),
          const SizedBox(width: 16.0),
          SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    media.artist,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(Constants.lighgray),
                    ),
                    overflow: TextOverflow.ellipsis, // Add this line
                    maxLines: 1, // Add this line
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    media.name,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(Constants.lighgray),
                    ),
                    overflow: TextOverflow.ellipsis, // Add this line
                    maxLines: 1, // Add this line
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }


  Widget postVideo() {
    return TextButton(
      onPressed: () {
        //TODO: LLAMAR A LA FUNCION QUE SUBE LA FOTO Y TE DEVUELVE LA ULR O ALGO ASI
        Post post = Post(
          LoginUser.instance.username!, // Replace with the actual username
          LoginUser.instance.onlineImage!, // Replace with the actual user profile
          widget.picture.path, // Assuming the video path is used as the post media
          media?.name ?? '', // Assuming media is the current selected media object
          media?.artist ?? '', // Assuming media is the current selected media object
          media?.image ?? '', // Assuming media is the current selected media object
          DateTime.now(),
        );
        DataManager().addPost(post);
        final nav = Navigator.of(context);
        nav.pop();
        nav.pop();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(Constants.lightblue), // Add your desired background color here
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        child: const Text(
          "Post Video",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }


  Widget video() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 135),
      child: Center(
        child: Image.file(File(widget.picture.path)), // Display the image
      ),
    );
  }
}