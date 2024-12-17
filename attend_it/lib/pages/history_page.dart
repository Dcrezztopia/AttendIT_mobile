import 'package:attend_it/provider/presensi_provider.dart';
import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  String selectedMonth = 'Semua'; // Default selected month
  int _currentIndex = 2; // Current index for the bottom navigation bar

  @override
  void initState() {
    super.initState();
    // Fetch presensi data when the page is initialized
    Future.microtask(() => ref.read(presensiProvider.notifier).fetchPresensi());
  }

  @override
  Widget build(BuildContext context) {
    final presensiList = ref.watch(presensiProvider);

    // Filter presensiList based on selectedMonth
    final filteredPresensiList = selectedMonth == 'Semua'
        ? presensiList
        : presensiList.where((presensi) {
            final month = DateTime.parse(presensi.tanggalPresensi).month;
            return _monthToString(month) == selectedMonth;
          }).toList();

    return Scaffold(
      appBar: const AppbarUserWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Histori Presensi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: <String>[
                    'Semua',
                    'Agustus',
                    'September',
                    'October',
                    'November',
                    'Desember'
                  ].map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPresensiList.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_outlined,
                          size: 70,
                          color: Color(0xFF0047AB),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Data Presensi Tidak Tersedia',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0047AB),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filteredPresensiList.length,
                    itemBuilder: (context, index) {
                      final presensi = filteredPresensiList[index];
                      return _buildAttendanceCard(
                        meetingNumber: presensi.pertemuanKe.toString(),
                        attendTime: presensi.tanggalPresensi,
                        courseTime:
                            '${presensi.jadwal.waktuMulai} - ${presensi.jadwal.waktuSelesai}',
                        course: presensi.jadwal.namaMatkul,
                        lecturer: presensi.jadwal.namaDosen,
                        status: presensi.statusPresensi,
                        statusColor: presensi.statusPresensi == 'hadir'
                            ? Colors.green
                            : Colors.red,
                      );
                    },
                  ),
          ),
        ],
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

  String _monthToString(int month) {
    switch (month) {
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  // Widget for individual attendance cards
  Widget _buildAttendanceCard({
    required String meetingNumber,
    required String attendTime,
    required String courseTime,
    required String course,
    required String lecturer,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pertemuan $meetingNumber - $attendTime',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              courseTime,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              course,
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              lecturer,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
