import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/face_recognition_service.dart';

final faceRecognitionProvider = Provider<FaceRecognitionService>((ref) {
  return FaceRecognitionService();
});

processImage(String path) {}
