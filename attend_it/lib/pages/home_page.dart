// pages/home_page.dart
import 'package:attend_it/pages/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            const SizedBox(height: 30),
            const Text(
              'Selamat Datang,',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const Text(
              'Kinata Dewa Ariandi',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildMenuItem(
                    SizedBox(
                      width: 100,
                      height: 90,
                      child: Image.asset('assets/images/jadwalHome.png'),
                    ),
                    'Lihat Jadwal',
                    Colors.white,
                    isGradient: true,
                    gradientColors: [Colors.green[800]!, Colors.green[300]!],
                  ),
                  _buildMenuItem(
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/presensiHome.png'),
                    ),
                    'Presensi',
                    Colors.white,
                    isGradient: true,
                    gradientColors: [
                      Color.fromARGB(255, 155, 41, 241),
                      Color(0xFFDBB0FD)
                    ],
                  ),
                  _buildMenuItem(
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset('assets/images/historyHome.png'),
                    ),
                    'History',
                    Colors.white,
                    isGradient: true,
                    gradientColors: [Colors.blue[800]!, Colors.blue[300]!],
                  ),

                  _buildMenuItem(
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/profileHome.png'),
                    ),
                    'Profile',
                    Colors.white,
                    isGradient: true,
                    gradientColors: [Colors.orange[800]!, Colors.orange[300]!],
                  ),

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

  BoxDecoration createGradient(List<Color> colors) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(40.0),
    );
  }

  Widget _buildMenuItem(Widget icon, String title, Color color,
      {bool isGradient = false, List<Color>? gradientColors}) {
    return Container(
      decoration: isGradient && gradientColors != null
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(40),
            )
          : BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
            ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon, // Gambar atau ikon yang digunakan
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

}
