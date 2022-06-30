import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

enum PictureScreenState { none, loading, loaded }

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  PictureScreenState _screenState = PictureScreenState.none;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product image')),
      body: _screenState == PictureScreenState.loaded
          ? _onLoaded()
          : _onLoading(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          _initializeControllerFuture
              .then((_) => _controller.takePicture())
              .then((picture) {
            Navigator.pop(context, picture);
          }).catchError(print);
        },
        // onPressed: () async {
        //   try {
        //     await _initializeControllerFuture;
        //     image = await _controller.takePicture();
        //     Navigator.pop(context);
        //   } catch (e) {
        //     print(e);
        //   }
        // },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _onLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _onLoaded() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _initializeCamera() async {
    _screenState = PictureScreenState.loading;
    if (mounted) {
      setState(() {});
    }

    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    _screenState = PictureScreenState.loaded;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
}
