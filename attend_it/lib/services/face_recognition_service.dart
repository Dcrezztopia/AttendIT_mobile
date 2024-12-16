import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceRecognitionService {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;

  // Define labels that match your model's output classes
  final Map<int, String> _labels = {
    0: 'Unknown',
    1: 'Mulki', // Replace with your actual model labels
    2: 'Dela',  // Replace with your actual model labels
    3: 'Kinata',  // Replace with your actual model labels
    4: 'Pascalis',  // Replace with your actual model labels
    // Add more labels as needed
  };

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/face_recognition_model_quantized.tflite');
      _isModelLoaded = true;
      print("Face recognition model loaded successfully");
    } catch (e) {
      print("Error loading model: $e");
      _isModelLoaded = false;
    }
  }

  Future<Map<String, dynamic>> processImage(String imagePath) async {
    try {
      if (!_isModelLoaded) await loadModel();

      // Read image file
      final imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();
      
      // Get input and output shapes
      final inputShape = _interpreter.getInputTensor(0).shape;
      final outputShape = _interpreter.getOutputTensor(0).shape;

      // Prepare input tensor
      var inputArray = bytes.map((byte) => byte / 255.0).toList();
      while (inputArray.length < inputShape.reduce((a, b) => a * b)) {
        inputArray.add(0.0);
      }

      // Prepare output tensor
      final outputSize = outputShape.reduce((a, b) => a * b);
      var outputArray = List<double>.filled(outputSize, 0);

      // Run inference
      _interpreter.run(inputArray, outputArray);

      // Find the class with highest confidence
      int maxIndex = 0;
      double maxConfidence = outputArray[0];
      
      for (var i = 1; i < outputArray.length; i++) {
        if (outputArray[i] > maxConfidence) {
          maxIndex = i;
          maxConfidence = outputArray[i];
        }
      }

      return {
        'predicted_name': _labels[maxIndex] ?? 'Unknown',
        'confidence': maxConfidence,
      };
    } catch (e) {
      print('Error in face recognition: $e');
      return {
        'predicted_name': 'Error',
        'confidence': 0.0,
      };
    }
  }

  void dispose() {
    if (_isModelLoaded) {
      _interpreter.close();
    }
  }
}