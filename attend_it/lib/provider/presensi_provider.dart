import 'package:attend_it/services/api_config.dart';
import 'package:attend_it/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/presensi.dart';

final presensiProvider =
    StateNotifierProvider<PresensiNotifier, List<Presensi>>((ref) {
  return PresensiNotifier();
});

class PresensiNotifier extends StateNotifier<List<Presensi>> {
  PresensiNotifier() : super([]);

  final SecureStorageService _storage = SecureStorageService();

  Future<void> fetchPresensi() async {
    try {
      // Retrieve token from secure storage
      final token = await _storage.readToken();
      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/presensi/riwayat'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> presensiList = data['presensi'];
        state = presensiList.map((json) => Presensi.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load presensi');
      }
    } catch (e) {
      print('Error fetching presensi: $e');
    }
  }
}
