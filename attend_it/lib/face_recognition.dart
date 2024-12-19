import 'dart:typed_data';
import 'package:attend_it/services/face_recognition_service.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';
import 'models/schedule.dart';

class FaceRecognitionPage extends StatefulWidget {
  final Schedule schedule; // Add schedule parameter

  const FaceRecognitionPage({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  _FaceRecognitionPageState createState() => _FaceRecognitionPageState();
}

class _FaceRecognitionPageState extends State<FaceRecognitionPage> {
  late CameraController _cameraController;
  late Interpreter _interpreter;
  late List<CameraDescription> cameras;
  final FaceRecognitionService _faceService = FaceRecognitionService();
  bool _isProcessing = false;
  late CameraImage _cameraImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      _cameraController = CameraController(
        cameras[1], // Use front camera (index 1)
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController.initialize();
      await _faceService.loadModel(); // Initialize face recognition model
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _processImage() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final image = await _cameraController.takePicture();

      // Process image using face recognition service
      final result = await _faceService.processImage(image.path);

      // Handle recognition result
      if (result['confidence'] > 0.7) {
        // Adjust threshold as needed
        await submitAttendance(widget.schedule.id.toString());
        _showSuccessDialog(result['predicted_name']);
      } else {
        _showErrorDialog('Face not recognized or confidence too low');
      }
    } catch (e) {
      print('Error processing image: $e');
      _showErrorDialog('Error processing image');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showSuccessDialog(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text('Attendance recorded for $name'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Return to PresensiPage
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Running inference
  // void runModel(Uint8List input) {
  //   // Get input and output tensors info
  //   final inputShape = _interpreter.getInputTensor(0).shape;
  //   final outputShape = _interpreter.getOutputTensor(0).shape;

  //   // Create input tensor
  //   final inputByteData = input.buffer.asByteData();
  //   final inputTensor = _allocateTensorBuffer(inputShape).asByteData();
  //   for (var i = 0; i < input.length; i++) {
  //     inputTensor.setUint8(i, inputByteData.getUint8(i));
  //   }

  //   // Prepare output tensor
  //   final outputTensor =
  //       ByteData(_allocateTensorBuffer(outputShape).lengthInBytes);

  //   // Run inference
  //   _interpreter.run(inputTensor, outputTensor);

  //   // Convert output to list of doubles
  //   final outputList =
  //       List<double>.filled(outputShape.reduce((a, b) => a * b), 0);
  //   final outputByteData = outputTensor;

  //   for (var i = 0; i < outputList.length; i++) {
  //     outputList[i] = outputByteData.getFloat32(i * 4, Endian.little);
  //   }

  //   print("Inference result: $outputList");
  //   postProcessOutput(outputList);
  // }

  ByteBuffer _allocateTensorBuffer(List<int> shape) {
    final size = shape.reduce((a, b) => a * b);
    return ByteData(size * 4).buffer;
  }

  // Postprocessing - Handle result from model
  void matchWithDatabase(List<double> modelOutput) {
    // Matching the detected face with database faces
    print("Matching with database...");
    // Database embedding matching logic goes here (e.g., Euclidean distance)
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Face Recognition - ${widget.schedule.namaMatkul}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(_cameraController),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Course: ${widget.schedule.namaMatkul}'),
                Text(
                    'Time: ${widget.schedule.waktuMulai} - ${widget.schedule.waktuSelesai}'),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _processImage,
                  child: _isProcessing
                      ? const CircularProgressIndicator()
                      : const Text('Take Attendance'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Modify postProcessOutput to handle attendance submission
  // void postProcessOutput(List<double> outputList) {
  //   // Add your face recognition logic here
  //   if (isValidFace(outputList)) {
  //     // Submit attendance
  //     submitAttendance(widget.schedule.id.toString());

  //     // Show success dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Success'),
  //         content: const Text('Attendance recorded successfully'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.of(context).pop(); // Return to PresensiPage
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // bool isValidFace(List<double> output) {
  //   // Implement your face validation logic
  //   // Return true if face is recognized
  //   return true; // Placeholder
  // }

  Future<void> submitAttendance(String scheduleId) async {
    // Implement attendance submission to backend
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
    _faceService.dispose();
    _interpreter.close();
  }
}
