// pages/home_page.dart
import 'package:attend_it/pages/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'Selamat Datang,',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF0047AB)),
            ),
            Text(
              'Kinata Dewa Ariandi',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF0047AB)),
            ),
            SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildMenuItem(
                      Icons.calendar_today, 'Lihat Jadwal', Colors.green),
                  _buildMenuItem(Icons.check, 'Presensi', Colors.purple),
                  _buildMenuItem(Icons.history, 'History', Colors.blue),
                  _buildMenuItem(Icons.person, 'Profile', Colors.orange),
                ],
              ),
            ),
          ],
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
      //   bottomNavigationBar: BottomNavigationBar(
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.history),
      //         label: 'History',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Profile',
      //       ),
      //     ],
      //     selectedItemColor: Colors.blue,
      //     unselectedItemColor: Colors.grey,
      //     currentIndex: 0,
      //   ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
