import 'dart:io';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class ApprovingPage extends StatefulWidget {
  final String imagePath;

  const ApprovingPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ApprovingPageState createState() => _ApprovingPageState();
}

class _ApprovingPageState extends State<ApprovingPage> {
  int _currentIndex = 1; // Current index for the bottom navigation bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Picture'),
        backgroundColor: const Color(0xFF0047AB),
      ),
      body: Column(
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
                        '00:00:00',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Add spacing
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
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
}