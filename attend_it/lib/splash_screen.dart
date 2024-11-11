import 'dart:async'; // For Future.delayed
import 'package:attend_it/pages/login_page.dart';
import 'package:flutter/material.dart';
// import './pages/home_page.dart'; // Import halaman utama

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Control for opacity and size animation
  double _logoSize = 100;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation(); // Start animation when splash screen loads

    // Navigate to the HomePage after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), // Redirect to HomePage
      );
    });
  }

  // Start animation by setting new size and opacity values
  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _logoSize = 200; // Grow the logo size
        _logoOpacity = 1.0; // Fade in the logo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              height: _logoSize,
              width: _logoSize,
              child: AnimatedOpacity(
                duration:
                    Duration(seconds: 2), // Animation duration for opacity
                opacity: _logoOpacity,
                child: Image.asset(
                    'assets/images/logo_jti.jpg'), // Replace with your app logo
              ),
            ),
            SizedBox(height: 20), // Space between logo and text
            AnimatedOpacity(
              duration: Duration(
                  seconds: 2), // Same animation duration for smooth effect
              opacity: _logoOpacity,
              child: Text(
                'PRESENSI', // Your desired text
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Customize text color as needed
                ),
              ),
            ),
            SizedBox(height: 20), // Space between logo and text
            AnimatedOpacity(
              duration: Duration(
                  seconds: 2), // Same animation duration for smooth effect
              opacity: _logoOpacity,
              child: Text(
                'ONLINE', // Your desired text
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey, // Customize text color as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
