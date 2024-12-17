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
        onTap(index); // Update the currentIndex first
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/home/presensi');
            break;
          case 2:
            context.go('/home/histori');
            break;
          case 3:
            context.go('/home/portal');
            break;
          case 4:
            context.go('/home/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.home_2), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.tick_square), label: 'Presensi'),
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.stickynote), label: 'Histori'),
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.link_square), label: 'Portal'),
        BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.user_square), label: 'Profile'),
      ],
    );
  }
}
