import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPublish extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const NewPublish({Key? key, required this.cameras}) : super(key:key);
  @override
  State<NewPublish> createState() => _NewPublishState();
}

class _NewPublishState extends State<NewPublish> {
  late CameraController _cameraController;

  Future initCamera(CameraDescription cameraDescription) async {
  // create a CameraController
    _cameraController = CameraController(cameraDescription, ResolutionPreset.high);

  // Next, initialize the controller. This returns a Future.
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // initialize the rear camera
    initCamera(widget.cameras![0]);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: _cameraController.value.isInitialized
                ? CameraPreview(_cameraController)
                : const Center(child:
            CircularProgressIndicator())));
  }
}