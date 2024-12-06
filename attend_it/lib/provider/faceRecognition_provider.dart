import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final faceRecognitionProvider = Provider<FaceRecognitionService>((ref) {
  return FaceRecognitionService();
});

class FaceRecognitionService {
  Future<String> getPredictedName(Map<String, dynamic> prediction) async {
    // Proses prediksi untuk nama
    return prediction['predicted_name'] ?? 'Unknown';
  }

  Future<double> getConfidence(Map<String, dynamic> prediction) async {
    // Proses prediksi untuk tingkat kepercayaan
    return prediction['confidence'] ?? 0.0;
  }
}
