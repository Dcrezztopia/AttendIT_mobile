import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    super.key, 
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF0C4DA2),
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
        BottomNavigationBarItem(icon: Icon(IconsaxPlusLinear.home_2), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(IconsaxPlusLinear.tick_square), label: 'Presensi'),
        BottomNavigationBarItem(icon: Icon(IconsaxPlusLinear.stickynote), label: 'Histori'),
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.calendar), label: 'schedule'),
        BottomNavigationBarItem(icon: Icon(IconsaxPlusLinear.user_square), label: 'profile'),
      ],
    );
  }
}
