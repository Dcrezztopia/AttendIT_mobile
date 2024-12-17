import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FaceRecognitionService {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  final Map<int, String> _labels = {
    0: 'Unknown',
    1: 'Mulki',
    2: 'Dela',
    3: 'Kinata',
    4: 'Pascalis',
  };

  Future<void> loadModel() async {
    if (_isModelLoaded) return;

    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/face_recognition_model_quantized.tflite',
        options: InterpreterOptions()..threads = 4,
      );
      _isModelLoaded = true;
      print("Model loaded successfully");
    } catch (e) {
      print("Error loading model: $e");
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

      // Resize image to 224x224
      final processedImage = img.copyResize(image, width: 224, height: 224);

      // Create input buffer with exact size
      var inputBuffer = List<int>.filled(1 * 224 * 224 * 3, 0);

      // Fill buffer linearly
      for (var y = 0; y < 224; y++) {
        for (var x = 0; x < 224; x++) {
          final pixel = processedImage.getPixel(x, y);
          final offset = (y * 224 + x) * 3;
          inputBuffer[offset] =
              ((pixel.r / 255.0) * 255 - 128).round().clamp(-128, 127);
          inputBuffer[offset + 1] =
              ((pixel.g / 255.0) * 255 - 128).round().clamp(-128, 127);
          inputBuffer[offset + 2] =
              ((pixel.b / 255.0) * 255 - 128).round().clamp(-128, 127);
        }
      }

      // Create output buffer with exact size
      final outputShape = _interpreter!.getOutputTensor(0).shape;
      final outputSize = outputShape.reduce((a, b) => a * b);
      final outputBuffer = List<int>.filled(outputSize, 0);

      // Allocate tensors
      _interpreter!.allocateTensors();

      // Run inference
      _interpreter!.run(inputBuffer, outputBuffer);

      // Process results
      int maxIndex = 0;
      int maxValue = outputBuffer[0];

      for (var i = 1; i < outputBuffer.length; i++) {
        if (outputBuffer[i] > maxValue) {
          maxIndex = i;
          maxValue = outputBuffer[i];
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
        'predicted_name': 'Error',
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
