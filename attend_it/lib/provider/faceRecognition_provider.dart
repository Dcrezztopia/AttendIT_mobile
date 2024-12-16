import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/face_recognition_service.dart';

final faceRecognitionProvider = Provider<FaceRecognitionService>((ref) {
  final service = FaceRecognitionService();
  service.loadModel(); // Pre-load the model
  return service;
});

  processImage(String path) {}