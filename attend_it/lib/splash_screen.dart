import 'dart:async'; // For Future.delayed
import 'package:attend_it/pages/login_page.dart';
import 'package:attend_it/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // Control for opacity and size animation
  double _logoSize = 100;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation(); // Start animation when splash screen loads
  }

  // Start animation by setting new size and opacity values
  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _logoSize = 200; // Grow the logo size
          _logoOpacity = 1.0; // Fade in the logo
        });
      }
    }).then((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          final authState = ref.read(authProvider);
          debugPrint('Auth State: ${authState.isAuthenticated}');
          if (authState.isAuthenticated) {
            context.go('/home');
          } else {
            context.go('/login');
          }
        }
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
              duration: const Duration(seconds: 2), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              height: _logoSize,
              width: _logoSize,
              child: AnimatedOpacity(
                duration: const Duration(
                    seconds: 2), // Animation duration for opacity
                opacity: _logoOpacity,
                child: Image.asset(
                    'assets/images/logo_jti.jpg'), // Replace with your app logo
              ),
            ),
            const SizedBox(height: 20), // Space between logo and text
            AnimatedOpacity(
              duration: const Duration(
                  seconds: 2), // Same animation duration for smooth effect
              opacity: _logoOpacity,
              child: const Text(
                'Attend IT', // Your desired text
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB), // Customize text color as needed
                ),
              ),
            ),
            // const SizedBox(height: 20), // Space between logo and text
            // AnimatedOpacity(
            //   duration: const Duration(
            //       seconds: 2), // Same animation duration for smooth effect
            //   opacity: _logoOpacity,
            //   child: const Text(
            //     'ONLINE', // Your desired text
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.grey, // Customize text color as needed
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
