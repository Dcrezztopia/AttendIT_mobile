import 'package:attend_it/pages/approving_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final Map<String, dynamic> schedule;

  const CameraPage({Key? key, required this.schedule}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller; // CameraController is nullable
  Future<void>? _initializeControllerFuture; // Future is nullable

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // Initialize the camera when the page loads
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw CameraException(
          'No camera available', 'There are no cameras on this device');
    }

    // Filter to find the front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras
          .first, // Fallback to the first camera if no front camera is available
    );

    // Initialize the CameraController with the selected camera
    _controller = CameraController(
      frontCamera, // Use the front-facing camera
      ResolutionPreset.medium,
    );

    // Initialize the controller and set the future
    _initializeControllerFuture = _controller!.initialize();

    // Ensure the widget rebuilds once the initialization is complete
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera for ${widget.schedule['course']}'),
        backgroundColor: const Color(0xFF0047AB),
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              // If the camera is initialized, display the camera preview
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller!);
              }

              // If the camera initialization failed, show an error
              else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // Show a loading spinner while waiting for initialization
              else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 20,
            right: 150,
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  // Ensure the camera is initialized
                  await _initializeControllerFuture;

                  // Attempt to take a picture and get the file path
                  final image = await _controller!.takePicture();

                  // If the picture is taken, navigate to a new screen to display it
                  if (mounted) {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ApprovingPage(
                          imagePath: image.path,
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  // Log any errors
                  print('Error capturing picture: $e');
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller to free up resources
    _controller?.dispose();
    super.dispose();
  }
}

// A screen to display the captured picture

