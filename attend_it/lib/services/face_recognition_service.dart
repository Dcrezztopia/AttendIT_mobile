import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:mime/mime.dart';

class FaceRecognitionService {
  final String baseUrl =
      'http://192.168.0.109:8000'; // FastAPI server URL for Android emulator

  Future<Map<String, dynamic>> processImage(String imagePath) async {
    try {
      final url = Uri.parse('$baseUrl/recognize');
      print('Sending request to: $url');

      // Debug: Print image info
      final imageFile = File(imagePath);
      print('Image exists: ${await imageFile.exists()}');
      print('Image size: ${await imageFile.length()} bytes');

      final mimeType = lookupMimeType(imagePath);
      print('MIME type: $mimeType');

      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imagePath,
          contentType: MediaType.parse(mimeType ?? 'image/jpeg'),
        ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        final result = json.decode(responseBody);
        if (result['results'] != null && result['results'].isNotEmpty) {
          final firstResult = result['results'][0];
          return {
            'predicted_name': firstResult['predicted_name'] ?? 'Unknown',
            'confidence': firstResult['confidence'] ?? 0.0,
          };
        } else if (result['error'] != null) {
          print('Server error: ${result['error']}');
          return {
            'predicted_name': 'Error: ${result['error']}',
            'confidence': 0.0,
          };
        } else {
          print('No faces detected in the image');
          return {
            'predicted_name': 'No face detected',
            'confidence': 0.0,
          };
        }
      } else {
        throw Exception('Failed to process image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in face recognition: $e');
      return {
        'predicted_name': 'Error',
        'confidence': 0.0,
      };
    }
  }

  void dispose() {
    // Clean up if needed
  }
}
