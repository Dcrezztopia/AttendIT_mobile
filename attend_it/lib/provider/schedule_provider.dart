import 'package:attend_it/services/api_config.dart';
import 'package:attend_it/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attend_it/models/schedule.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleNotifier extends StateNotifier<List<Schedule>> {
  ScheduleNotifier() : super([]);

  final SecureStorageService _storage = SecureStorageService();
  Schedule? selectedSchedule; // Jadwal yang dipilih

  // Fetch schedules from API
  Future<void> fetchSchedules() async {
    try {
      // Ambil token dari storage
      final token = await _storage.readToken();
      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/jadwal'),
        headers: {
          'Authorization': 'Bearer $token', // Sertakan Bearer Token
        },
      );
      if (response.statusCode == 200) {
        print('Respon API: ${response.body}');
        Map<String, dynamic> data = json.decode(response.body);
        // Pastikan key `jadwals` ada
        if (data.containsKey('jadwals')) {
          List<dynamic> jadwals = data['jadwals'];
          print('Data jadwal: $data');
          state = jadwals.map((json) => Schedule.fromJson(json)).toList();
        } else {
          print('Key "jadwals" tidak ditemukan dalam respons.');
          state = [];
        }
      } else {
        print('Failed to fetch schedules. Status: ${response.statusCode}');
        print('Respon API: ${response.body}');
        throw Exception('Failed to fetch schedules');
      }
    } catch (e) {
      // Handle errors (e.g., log to console or show UI error message)
      state = [];
    }
  }

    // Fungsi untuk menyimpan jadwal pilihan
    void selectSchedule(Schedule schedule) {
      selectedSchedule = schedule;
    }
  
}

final scheduleProvider =
    StateNotifierProvider<ScheduleNotifier, List<Schedule>>((ref) {
  return ScheduleNotifier();
});
