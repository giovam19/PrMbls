import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(picture.name)
        ]),
      ),
    );
  }
   */

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 390,
        height: 844,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
        child: Stack(children: <Widget>[
          // Music box
          Positioned(
              top: 90,
              left: 40,
              child: Container(
                  width: 308,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ))),
          // Music text
          Positioned(
              top: 100,
              left: 60,
              child: Text(
                'Music',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          // Artist text
          Positioned(
              top: 292,
              left: 172,
              child: Text(
                'Artist',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          // Title song text
          Positioned(
              top: 240,
              left: 167,
              child: Text(
                'Title',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          // Song box
          Positioned(
              top: 150,
              left: 40,
              child: Container(
                  width: 308,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ))),
          // Search button
          Positioned(
              top: 156,
              left: 255,
              child: Container(
                  width: 86,
                  height: 28,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 86,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: Color.fromRGBO(172, 172, 172, 1),
                            ))),
                    // Search text
                    Positioned(
                        top: 8,
                        left: 20,
                        child: Text(
                          'Search',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          // Song text
          Positioned(
              top: 160,
              left: 60,
              child: Text(
                'Song',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(172, 172, 172, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          // Song photo box
          Positioned(
              top: 220,
              left: 41,
              child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                  ))),
          // Video display
          Positioned(
              top: 403,
              left: 41,
              child: Container(
                  width: 308,
                  height: 308,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 308,
                            height: 308,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ))),
                    // Video text
                    Positioned(
                        top: 135,
                        left: 111,
                        child: Text(
                          'Video',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          // Photo text
          Positioned(
              top: 272,
              left: 53,
              child: Text(
                'Photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          // Take video container
          Positioned(
              top: 755,
              left: 98,
              child: Container(
                  width: 193,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Color.fromRGBO(171, 171, 171, 0.8100000023841858),
                  ))),
          // Take video text
          Positioned(
              top: 500,
              left: 118,
              child: Text(
                'Take Video',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
        ]));
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          emailField(),
          emailField(),
          video(),
          takeVideo(),
        ]
      ),

    );
  }
*/



  Widget emailField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Song",
          hintStyle: TextStyle(color: Colors.black45),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: search()
        ),
      ),
    );
  }

  Widget search() {
    return TextButton(
        onPressed: () {  },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: const Text(
            "Search",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        )
    );
  }

  Widget takeVideo() {
    return TextButton(
        onPressed: () {  },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
          child: const Text(
            "Take Video",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        )
    );
  }

  Widget video() {
    return Container(
      padding: EdgeInsets.all(120.0),
      color: Colors.cyan,
      child: const Text("Video",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 360,
              height: 752,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 94,
                    left: 14,
                    child: Container(
                      width: 308,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color : Color.fromRGBO(255, 255, 255, 1),
                      )
                    )
                  ),
                  Positioned(
                    top: 100,
                    left: 231,
                    child: Container(
                      width: 86,
                      height: 28,
                      decoration: const BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color : Color.fromRGBO(172, 172, 172, 1),
                      )
                    )
                  ),
                  Positioned(
                    top: 0,
                    left: 14,
                    child: Container(
                      width: 308,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color : Color.fromRGBO(255, 255, 255, 1),
                      )
                    )
                  ),
                  const Positioned(
                    top: 2,
                    left: 21,
                    child: Text('Music', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  const Positioned(
                    top: 249,
                    left: 145,
                    child: Text('Artist', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  const Positioned(
                    top: 197,
                    left: 140,
                    child: Text('Title', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  const Positioned(
                    top: 100,
                    left: 231,
                    child: Text('Search', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  const Positioned(
                    top: 96,
                    left: 0,
                    child: Text('Song', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(172, 172, 172, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  Positioned(
                    top: 360,
                    left: 14,
                    child: Container(
                      width: 308,
                      height: 308,
                      decoration: const BoxDecoration(
                        color : Color.fromRGBO(217, 217, 217, 1),
                      )
                    )
                  ),
                  Positioned(
                    top: 192,
                    left: 14,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        color : Color.fromRGBO(217, 217, 217, 1),
                      )
                    )
                  ),
                  const Positioned(
                    top: 495,
                    left: 125,
                    child: Text('Video', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  const Positioned(
                    top: 229,
                    left: 26,
                    child: Text('Photo', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                  Positioned(
                    top: 712,
                    left: 71,
                    child: Container(
                      width: 193,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color : Color.fromRGBO(171, 171, 171, 0.8100000023841858),
                      )
                    )
                  ),
                  const Positioned(
                    top: 713,
                    left: 91,
                    child: Text('Take Video', textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                      ),
                    )
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }

 */

}