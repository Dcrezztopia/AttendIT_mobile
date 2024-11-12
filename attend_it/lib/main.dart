import 'package:attend_it/pages/login_page.dart';
import 'package:attend_it/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Import halaman HomePage dari folder pages
import 'pages/presensi_page.dart'; // Import halaman PresensiPage dari folder pages

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attend IT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/presensi': (context) => const PresensiPage(),
        // '/profile': (context) => ProfilePage(),
      },
    );
  }
}
