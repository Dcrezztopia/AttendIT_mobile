import 'package:attend_it/services/api_config.dart';
import 'package:attend_it/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final statisticsProvider =
    StateNotifierProvider<StatisticsNotifier, Map<String, int>>((ref) {
  return StatisticsNotifier();
});

class StatisticsNotifier extends StateNotifier<Map<String, int>> {
  StatisticsNotifier() : super({'hadir': 0, 'alpha': 0, 'izin': 0, 'sakit': 0});

  final SecureStorageService _storage = SecureStorageService();

  Future<void> fetchStatistics() async {
    try {
      // Retrieve token from secure storage
      final token = await _storage.readToken();
      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/presensi/statistik'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        state = Map<String, int>.from(data['statistics']);
      } else {
        throw Exception('Failed to load statistics');
      }
    } catch (e) {
      print('Error fetching statistics: $e');
    }
  }
}
