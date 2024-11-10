import 'package:attend_it/pages/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  int _currentIndex = 1; // Index for Bottom Navigation Bar

  final List<Map<String, String>> schedules = [
    {
      "time": "07.00 - 12.10",
      "course": "Pemrograman Mobile",
      "lecturer": "Sofyan Noor Arief S.ST.,M.Kom",
      "room": "LKJ2_7T"
    },
    {
      "time": "14.30 - 18.00",
      "course": "Metodologi Penelitian",
      "lecturer": "Ulia Rosiana",
      "room": "LKJ2_7T"
    },
    {
      "time": "07.00 - 12.10",
      "course": "Pembelajaran Mesin",
      "lecturer": "Ely Setyo Astuti",
      "room": "LKJ2_7T"
    },
    {
      "time": "14.30 - 16.20",
      "course": "Kewarganegaraan",
      "lecturer": "Dr. Widayaningish",
      "room": "LKJ2_7T"
    },
    {
      "time": "07.00 - 10.30",
      "course": "Administrasi dan Keamanan Jaringan",
      "lecturer": "Ade Ismail",
      "room": "LKJ2_7T"
    },
    {
      "time": "14.30 - 18.00",
      "course": "Bahasa Inggris Persiapan Kerja",
      "lecturer": "Atiqah Nurul Asri",
      "room": "LKJ2_7T"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jadwal Kuliah"),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule['time'] ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      schedule['course'] ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(schedule['lecturer'] ?? ''),
                    SizedBox(height: 4),
                    Text(schedule['room'] ?? '',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          );
        },
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
