import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}
class _HistoryPageState extends State<HistoryPage> {

  String selectedMonth = 'September'; // Default selected month
  int _currentIndex = 2; // Current index for the bottom navigation bar
  // Example user data
  final String userName = "Kinata Dewa Ariandi";
  final String userId = "2241720087";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppbarUserWidget(
        userName: userName,
        userId: userId,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), // Rentang awal
                      lastDate: DateTime(2100), // Rentang akhir
                      initialDatePickerMode:
                          DatePickerMode.year, // Fokus di tahun
                      helpText: "Pilih Bulan", // Judul picker
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedMonth = DateFormat('MMMM')
                            .format(pickedDate); // Format bulan
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedMonth,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.calendar_today,
                            size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildAttendanceCard(
                  time: '14.30 - 17.10',
                  course: 'Pemrograman Mobile',
                  lecturer: 'Sofyan Noor Arief S.T., M.Kom',
                  status: 'Terlambat',
                  statusColor: Colors.red,
                ),
                const SizedBox(height: 16),
                _buildAttendanceCard(
                  time: '14.30 - 17.10',
                  course: 'Metodologi Penelitian',
                  lecturer: 'Ulla Delfina Rosiani S.T., MT., Dr',
                  status: 'Hadir',
                  statusColor: Colors.green,
                ),
              ],
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

  // Widget for individual attendance cards
  Widget _buildAttendanceCard({
    required String time,
    required String course,
    required String lecturer,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                  color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              course,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
            ),
            Text(
              lecturer,
                style: TextStyle(
                fontSize: 14,
                  color: Colors.grey.shade600,
              ),
            ),
              const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: statusColor,
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
