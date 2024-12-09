import 'package:go_router/go_router.dart';
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
      selectedItemColor: const Color(0xFF0C4DA2),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          context.go('/home'); // Navigasi ke halaman Home
        }
        if (index == 1) {
          context.go('/presensi'); // Navigasi ke halaman Presensi
        }
        if (index == 2) {
          context.go('/histori'); // Navigasi ke halaman Histori
        }
        if (index == 3) {
          context.go('/schedule'); // Navigasi ke halaman Schedule
        }
        if (index == 4) {
          context.go('/profile'); // Navigasi ke halaman Profile
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
