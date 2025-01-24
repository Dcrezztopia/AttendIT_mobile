// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:attend_it/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ApprovingPage extends ConsumerStatefulWidget {
  final String imagePath;
  final Schedule selectedSchedule;
  final DateTime captureTime;

  const ApprovingPage(
      {super.key,
      required this.imagePath,
      required this.selectedSchedule,
      required this.captureTime});

  @override
  _ApprovingPageState createState() => _ApprovingPageState();
}

class _ApprovingPageState extends ConsumerState<ApprovingPage> {
  @override
  Widget build(BuildContext context) {
    // Format waktu untuk ditampilkan
    final formattedDate =
        "${widget.captureTime.day}-${widget.captureTime.month}-${widget.captureTime.year}";
    final formattedTime =
        "${widget.captureTime.hour}:${widget.captureTime.minute}:${widget.captureTime.second}";

    // Hitung keterlambatan
    final jadwalMulai = TimeOfDay(
      hour: int.parse(widget.selectedSchedule.waktuMulai.split(':')[0]),
      minute: int.parse(widget.selectedSchedule.waktuMulai.split(':')[1]),
    );

    final presensiTime = TimeOfDay(
      hour: widget.captureTime.hour,
      minute: widget.captureTime.minute,
    );

    final keterlambatan = calculateLateness(presensiTime, jadwalMulai);

    return WillPopScope(
      onWillPop: () async {
        context.go('/home/presensi');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Presensi'),
          backgroundColor: const Color(0xFF0047AB),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/home/presensi'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.file(
                              File(widget.imagePath),
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$formattedTime $formattedDate',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Jam Kehadiran',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$formattedTime WIB',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Waktu Terlambat',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  keterlambatan,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Mata Kuliah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.selectedSchedule.namaMatkul,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Dosen',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.selectedSchedule.namaDosen,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      const Positioned(
                        bottom: -50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculateLateness(TimeOfDay presensi, TimeOfDay jadwal) {
    final presensiMinutes = presensi.hour * 60 + presensi.minute;
    final jadwalMinutes = jadwal.hour * 60 + jadwal.minute;
    final diff = presensiMinutes - jadwalMinutes;

    if (diff <= 0) return '00:00:00';

    final hours = diff ~/ 60;
    final minutes = diff % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00';
  }
}
