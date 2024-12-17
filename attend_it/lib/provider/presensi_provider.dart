import 'package:attend_it/models/presensi.dart';
import 'package:attend_it/services/api_config.dart';
import 'package:attend_it/services/secure_storage_service.dart';
import 'package:attend_it/utils/pertemuan_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> submitPresensi({
    required int idJadwal,
    required String waktuMulai,
    required DateTime captureTime,
  }) async {
    try {
      final tanggalPresensi = "${captureTime.year}-${captureTime.month.toString().padLeft(2, '0')}-${captureTime.day.toString().padLeft(2, '0')}";
      
      final pertemuanKe = PertemuanHelper.getPertemuanKe(tanggalPresensi);
      if (pertemuanKe == 0) {
        throw Exception('Tidak ada jadwal pertemuan hari ini');
      }

      final jadwalMulai = TimeOfDay(
        hour: int.parse(waktuMulai.split(':')[0]),
        minute: int.parse(waktuMulai.split(':')[1]),
      );
      
      final presensiTime = TimeOfDay(
        hour: captureTime.hour,
        minute: captureTime.minute
      );
      
      final statusPresensi = isOnTime(presensiTime, jadwalMulai) ? 'hadir' : 'alpha';

      final token = await _storage.readToken();
      if (token == null) throw Exception('Token tidak tersedia');

      final response = await http.post(
        Uri.parse('$baseUrl/presensi/submit'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_jadwal': idJadwal,
          'pertemuan_ke': pertemuanKe,
          'tanggal_presensi': tanggalPresensi,
          'status_presensi': statusPresensi,
          'tahun_ajaran': '2024/2025',
        }),
      );

      if (response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal melakukan presensi');
      }

      await fetchPresensi(); // Refresh daftar presensi
    } catch (e) {
      rethrow;
    }
  }
  bool isOnTime(TimeOfDay presensi, TimeOfDay jadwal) {
    final presensiMinutes = presensi.hour * 60 + presensi.minute;
    final jadwalMinutes = jadwal.hour * 60 + jadwal.minute;
    return (presensiMinutes - jadwalMinutes) <= 1;
  }
}
