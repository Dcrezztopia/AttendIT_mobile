import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _currentIndex = 2;

  final String userName = "Kinata Dewa Ariandi"; // Ganti dengan data user login
  final String userId = "2241720087"; // Ganti dengan data user login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarUserWidget(
        userName: userName, 
        userId: userId
      ),
      body: const Column(),
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