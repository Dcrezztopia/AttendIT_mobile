import 'dart:io';
import 'package:attend_it/models/schedule.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attend_it/provider/presensi_provider.dart';
import 'package:go_router/go_router.dart';

class ApprovingPage extends ConsumerStatefulWidget {
  final String imagePath;
  final Schedule selectedSchedule;

  const ApprovingPage(
      {Key? key, required this.imagePath, required this.selectedSchedule})
      : super(key: key);

  @override
  _ApprovingPageState createState() => _ApprovingPageState();
}

class _ApprovingPageState extends ConsumerState<ApprovingPage> {
  int _currentIndex = 1; // Current index for the bottom navigation bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Picture'),
        backgroundColor: const Color(0xFF0047AB),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20), // Add spacing
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
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
                                // get tanggal dan waktu tepat melakukan pengambilan gambar
                                '07:15:50 11-11-2021',
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
                          const Text(
                            // get waktu melakukan pengambilan gambar
                            '06:50:45 WIB',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                          const Text(
                            // perhitungan set waktuMulai - waktu pengambilan gambar
                            '00:00:00',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
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
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add spacing
              Center(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      print('Button tapped - starting attendance submission');
                      final now = DateTime.now();
                      print('Current time: $now');
                      
                      await ref.read(presensiProvider.notifier).submitPresensi(
                        idJadwal: widget.selectedSchedule.id,
                        waktuMulai: widget.selectedSchedule.waktuMulai,
                        captureTime: now,
                      );
                      print('Attendance submitted successfully');

                      if (mounted) {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Presensi berhasil disimpan')),
                        );
                        // Navigate back to presensi page
                        context.go('/home/presensi');
                      }
                    } catch (e) {
                      print('Error submitting attendance: $e');
                      // Show error message
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal menyimpan presensi: $e')),
                        );
                      }
                    }
                  },
                  child: const CircleAvatar(
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
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
