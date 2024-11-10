import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home'); // Navigasi ke halaman History
        }
        if (index == 1) {
          Navigator.pushNamed(
              context, '/presensi'); // Navigasi ke halaman History
        }
        if (index == 4) {
          Navigator.pushNamed(
              context, '/profile'); // Navigasi ke halaman History
        }
        onTap(index); // Tetap panggil fungsi onTap eksternal
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Presensi'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histori'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'schedule'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
      ],
    );
  }
}
