import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Import halaman HomePage dari folder pages
import 'pages/presensi_page.dart'; // Import halaman PresensiPage dari folder pages

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attend IT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: {
        // '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/presensi': (context) => PresensiPage(),
        // '/profile': (context) => ProfilePage(),
      },
    );
  }
}
