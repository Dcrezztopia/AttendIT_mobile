import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/face_recognition_service.dart';

final faceRecognitionProvider = Provider<FaceRecognitionService>((ref) {
  final service = FaceRecognitionService();
  // Initialize the model asynchronously
  service.loadModel().catchError((error) {
    print('Failed to initialize face recognition: $error');
  });
  return service;
});

processImage(String path) {}
