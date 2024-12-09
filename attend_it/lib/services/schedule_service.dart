import 'dart:convert';
import 'package:attend_it/models/schedule.dart';
import 'package:http/http.dart' as http;

class ScheduleService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Schedule>> getSchedules() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwal'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> jadwalList = data['jadwals'];

      return jadwalList.map((json) => Schedule.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}
