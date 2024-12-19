import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FaceRecognitionService {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  Map<int, String> _labels = {}; // Changed to empty map initially

  Future<void> loadModel() async {
    if (_isModelLoaded) return;

    try {
      // Load model
      _interpreter = await Interpreter.fromAsset(
        'assets/models/face_recognition_model_quantized.tflite',
        options: InterpreterOptions()..threads = 4,
      );

      // Load labels
      final labelsData =
          await rootBundle.loadString('assets/models/labels.txt');
      final labelsList = labelsData.split('\n');
      _labels = {
        for (var i = 0; i < labelsList.length; i++) i: labelsList[i].trim()
      };

      _isModelLoaded = true;
      print("Model loaded successfully");
    } catch (e) {
      print("Error loading model or labels: $e");
      _isModelLoaded = false;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> processImage(String imagePath) async {
    try {
      if (!_isModelLoaded) {
        await loadModel();
      }

      if (_interpreter == null) {
        throw Exception('Model not loaded');
      }

      // Load and preprocess the image
      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image == null) throw Exception('Failed to load image');

      // Define input shape [batch, height, width, channels]
      var inputShape = [1, 100, 100, 1];

      // Create 4D input tensor array using inputShape
      var inputArray = List<List<List<List<int>>>>.generate(
        // Changed to int
        inputShape[0],
        (_) => List<List<List<int>>>.generate(
          inputShape[1],
          (_) => List<List<int>>.generate(
            inputShape[2],
            (_) => List<int>.filled(inputShape[3], 0),
          ),
        ),
      );

      // Resize image to match input shape
      final processedImage = img.copyResize(
        image,
        width: inputShape[2], // 100
        height: inputShape[1], // 100
      );

      for (var y = 0; y < inputShape[1]; y++) {
        for (var x = 0; x < inputShape[2]; x++) {
          final pixel = processedImage.getPixel(x, y);
          // Convert RGB to grayscale using luminance formula
          final grayscale =
              (0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b);
          // Convert to int8 range (-128 to 127)
          inputArray[0][y][x][0] =
              ((grayscale / 255.0) * 255 - 128).round().clamp(-128, 127);
        }
      }

      // Create output array matching the model's output shape [1, 10]
      var outputArray = List<List<int>>.generate(
        1,
        (_) => List<int>.filled(10, 0),
      );

      // Run inference
      _interpreter!.run(inputArray, outputArray);

      // Process results - now handling 2D output array
      int maxIndex = 0;
      int maxValue = outputArray[0][0];

      for (var i = 0; i < outputArray[0].length; i++) {
        if (outputArray[0][i] > maxValue) {
          maxIndex = i;
          maxValue = outputArray[0][i];
        }
      }

      // Convert the int8 output to confidence score (0-1 range)
      double confidence = (maxValue + 128) / 255.0;

      return {
        'predicted_name': _labels[maxIndex] ?? 'Unknown',
        'confidence': confidence,
      };
    } catch (e) {
      print('Error in face recognition: $e');
      return {
        'predicted_name': 'Unknown',
        'confidence': 0.0,
      };
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isModelLoaded = false;
  }
}
