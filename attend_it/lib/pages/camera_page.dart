import 'package:attend_it/pages/approving_page.dart';
import 'package:attend_it/provider/schedule_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:attend_it/widgets/identity_confirmation_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:attend_it/provider/faceRecognition_provider.dart';
// import 'package:attend_it/provider/student_mapping_provider.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw CameraException(
          'No camera available', 'There are no cameras on this device');
    }

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedSchedule =
        ref.watch(scheduleProvider.notifier).selectedSchedule;

    // final selectedSchedule =
    //     ref.watch(scheduleProvider.notifier).selectedSchedule;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home/presensi'),
        ),
        title: Text('Camera for ${selectedSchedule?.namaMatkul}'),
        backgroundColor: const Color(0xFF0047AB),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller!);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: FloatingActionButton(
                onPressed: () async {
                  if (_isTakingPicture) return; // Prevent multiple captures
                  setState(() => _isTakingPicture = true);
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller!.takePicture();
                    final selectedSchedule =
                        ref.read(scheduleProvider.notifier).selectedSchedule;

                    // Process image through face recognition
                    final faceRecognitionService =
                        ref.read(faceRecognitionProvider);
                    final result =
                        await faceRecognitionService.processImage(image.path);

                    if (mounted) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return IdentityConfirmationDialog(
                            predictedName: result['predicted_name'],
                            confidence: result['confidence'],
                            onConfirm: () {
                              Navigator.of(context).pop();
                              if (selectedSchedule != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ApprovingPage(
                                      imagePath: image.path,
                                      selectedSchedule: selectedSchedule,
                                    ),
                                  ),
                                );
                              }
                            },
                            onRetake: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                  } catch (e) {
                    print('Error capturing picture: $e');
                  } finally {
                    setState(() => _isTakingPicture = false);
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
    _controller?.dispose();
    super.dispose();
  }
}

// A screen to display the captured picture

