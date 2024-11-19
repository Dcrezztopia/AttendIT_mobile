import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  int _currentIndex = 1; // Index for Bottom Navigation Bar

  // Contoh data pengguna yang login
  final String userName = "Kinata Dewa Ariandi"; // Ganti dengan data user login
  final String userId = "2241720087"; // Ganti dengan data user login

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
      "lecturer": "Ulla Rosiana",
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
      appBar: AppbarUserWidget(
        userName: userName, 
        userId: userId
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
              color: const Color.fromARGB(255, 255, 255, 255),
              shadowColor:
                  const Color.fromARGB(255, 31, 30, 30).withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Color(0xFF0047AB)),
                        const SizedBox(width: 6),
                        Text(
                          schedule['time'] ?? '',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Text(
                      schedule['course'] ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF0047AB)),
                        const SizedBox(width: 7),
                        Text(
                          schedule['lecturer'] ?? '',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xFF0047AB)),
                        const SizedBox(width: 7),
                        Text(
                          schedule['room'] ?? '',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
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
