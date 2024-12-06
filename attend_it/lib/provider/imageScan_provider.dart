import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// Provider untuk fungsi upload gambar
final imageUploadProvider = Provider<ImageUploadService>((ref) {
  return ImageUploadService();
});

// Kelas untuk mengelola upload gambar ke FastAPI
class ImageUploadService {
  Future<Map<String, dynamic>> handleImageUpload(File imageFile, BuildContext context) async {
    try {
      // Update URL to match your FastAPI endpoint
      final url = Uri.parse("http://10.0.2.2:8000/recognize/");
      
      final mimeType = lookupMimeType(imageFile.path);
      
      // Validasi mimeType
      if (mimeType == null) {
        throw Exception("Unable to determine MIME type of the file.");
      }
      
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath(
          'file', // Sesuai parameter di FastAPI
          imageFile.path,
          contentType: MediaType.parse(mimeType),
        ));
      
      final response = await request.send();
      
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        
        // Decode respons dari JSON
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        
        // Validasi dan ekstraksi data yang diperlukan
        if (responseData.containsKey('predicted_name') && responseData.containsKey('confidence')) {
          return {
            'predicted_name': responseData['predicted_name'],
            'confidence': responseData['confidence'],
          };
        } else {
          throw Exception("Invalid response data.");
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception("Failed to upload image: ${response.statusCode}, $responseBody");
      }
    } catch (e) {
      print("Error uploading image: $e");
      
      // Tampilkan error atau snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      
      rethrow; // Lempar ulang exception jika terjadi kesalahan
    }
  }
}