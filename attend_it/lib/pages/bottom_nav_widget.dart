import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GNav(
        haptic: true, // haptic feedback
        // tab button shadow
        curve: Curves.easeOutExpo, // tab animation curves
        duration: const Duration(seconds: 1), // tab animation duration
        gap: 5, // the tab button gap between icon and text
        color: const Color.fromARGB(255, 74, 73, 73)!, // unselected icon color
        activeColor: Color(0xFF0047AB),
        iconSize: 27,
        tabBackgroundColor:
            Colors.lightBlue.withOpacity(0.1), // selected tab background color
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        selectedIndex: currentIndex,
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/presensi');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/history');
          }
          if (index == 3) {
            Navigator.pushNamed(context, '/schedule');
          }
          if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          }
          onTap(index);
        },
        tabs: const [
          GButton(
            icon: IconsaxPlusLinear.home_2,
            text: 'Home',
          ),
          GButton(
            icon: IconsaxPlusLinear.tick_square,
            text: 'Presensi',
          ),
          GButton(
            icon: IconsaxPlusLinear.stickynote,
            text: 'Histori',
          ),
          GButton(
            icon: IconsaxPlusLinear.calendar,
            text: 'Schedule',
          ),
          GButton(
            icon: IconsaxPlusLinear.user_square,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
