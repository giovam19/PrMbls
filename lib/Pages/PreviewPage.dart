import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pr_mbls/Managers/APIManager.dart';
import 'package:pr_mbls/Managers/DataManager.dart';
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
  String? selectedOption;


  void _performSearch(String query) async {
    APIManager().onChangeType(selectedOption!);
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
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: (value) {
          setState(() {
            selectedOption = value;
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
    );
  }

/*
  Widget songSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: TextField(
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
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _performSearch(searchQuery);
            },
          ),
        ),
      ),
    );
  }

 */

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
            APIManager().search(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black45),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                APIManager().search(searchQuery);
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
          APIManager().search(suggestion.name);
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
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              'Photo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                media.artist,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                media.name,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget postVideo() {
    return TextButton(
      onPressed: () {
        Post post = Post(
          'username', // Replace with the actual username
          'userprofile', // Replace with the actual user profile
          widget.picture.path, // Assuming the video path is used as the post media
          media?.name ?? '', // Assuming media is the current selected media object
          media?.artist ?? '', // Assuming media is the current selected media object
          media?.image.toString() ?? '', // Assuming media is the current selected media object
          DateTime.now(),
        );
        DataManager().addPost(post);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
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