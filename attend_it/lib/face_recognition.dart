import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';
import 'models/schedule.dart';

class FaceRecognitionPage extends StatefulWidget {
  final Schedule schedule;  // Add schedule parameter
  
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
  late CameraImage _cameraImage;

  @override
  void initState() {
    super.initState();
    loadModel();
    initializeCamera();
  }

  void loadModel() async {
    _interpreter = await Interpreter.fromAsset('face_recognition_model.tflite');
    print("Model loaded successfully");
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    _cameraController.startImageStream((CameraImage image) {
      setState(() {
        _cameraImage = image;
      });
    });
  }

  // Running inference
  void runModel(Uint8List input) {
    // Get input and output tensors info
    final inputShape = _interpreter.getInputTensor(0).shape;
    final outputShape = _interpreter.getOutputTensor(0).shape;
    
    // Create input tensor
    final inputByteData = input.buffer.asByteData();
    final inputTensor = _allocateTensorBuffer(inputShape).asByteData();
    for (var i = 0; i < input.length; i++) {
      inputTensor.setUint8(i, inputByteData.getUint8(i));
    }

    // Prepare output tensor
    final outputTensor = ByteData(_allocateTensorBuffer(outputShape).lengthInBytes);
    
    // Run inference
    _interpreter.run(inputTensor, outputTensor);

    // Convert output to list of doubles
    final outputList = List<double>.filled(outputShape.reduce((a, b) => a * b), 0);
    final outputByteData = outputTensor;
    
    for (var i = 0; i < outputList.length; i++) {
      outputList[i] = outputByteData.getFloat32(i * 4, Endian.little);
    }

    print("Inference result: $outputList");
    postProcessOutput(outputList);
  }

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
                Text('Time: ${widget.schedule.waktuMulai} - ${widget.schedule.waktuSelesai}'),
                ElevatedButton(
                  onPressed: () async {
                    final image = await _cameraController.takePicture();
                    final bytes = await image.readAsBytes();
                    runModel(bytes);
                  },
                  child: const Text('Take Attendance'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Modify postProcessOutput to handle attendance submission
  void postProcessOutput(List<double> outputList) {
    // Add your face recognition logic here
    if (isValidFace(outputList)) {
      // Submit attendance
      submitAttendance(widget.schedule.id.toString());
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Attendance recorded successfully'),
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
  }

  bool isValidFace(List<double> output) {
    // Implement your face validation logic
    // Return true if face is recognized
    return true; // Placeholder
  }

  Future<void> submitAttendance(String scheduleId) async {
    // Implement attendance submission to backend
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
    _interpreter.close();
  }
}
