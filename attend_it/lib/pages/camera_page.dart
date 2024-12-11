import 'package:attend_it/pages/approving_page.dart';
import 'package:attend_it/provider/schedule_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
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
    final selectedSchedule =
        ref.watch(scheduleProvider.notifier).selectedSchedule;

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera for ${selectedSchedule?.namaMatkul}'),
        backgroundColor: const Color(0xFF0047AB),
      ),
      body: Stack(
        children: [
          Expanded(
            child: FutureBuilder<void>(
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: FloatingActionButton(
                onPressed: () async {
                  // Logika tombol tetap sama seperti sebelumnya
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller!.takePicture();
                    final selectedSchedule =
                        ref.read(scheduleProvider.notifier).selectedSchedule;

                    if (selectedSchedule != null) {
                      if (mounted) {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ApprovingPage(
                              imagePath: image.path,
                              selectedSchedule: selectedSchedule,
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No schedule selected!')),
                      );
                    }
                  } catch (e) {
                    print('Error capturing picture: $e');
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
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

