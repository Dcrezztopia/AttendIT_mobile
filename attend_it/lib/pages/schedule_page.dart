import 'package:flutter/material.dart';

import '../widgets/appbar_user_widget.dart';
import '../widgets/bottom_nav_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _currentIndex = 3;

  final String userName = "Kinata Dewa Ariandi"; // Ganti dengan data user login
  final String userId = "2241720087"; // Ganti dengan data user login
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarUserWidget(
        userName: userName, 
        userId: userId
      ),
      body: const Column(
        
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