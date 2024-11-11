import 'package:attend_it/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo_jti.jpg',
                  height: 100,
                ),
                SizedBox(height: 20),

                // Title
                Text(
                  'Presensi Online',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3D7B),
                  ),
                ),
                Text(
                  'JTI Polinema',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1F3D7B),
                  ),
                ),
                SizedBox(height: 30),

                // NIM Input
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Password Input
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Remember Me Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: false, // Set sesuai kebutuhan
                      onChanged: (bool? value) {
                        // Handle checkbox change
                      },
                    ),
                    Text(
                      'Ingat Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Login Button and Fingerprint Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigasi ke HomePage setelah login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage()), // Ganti HomePage dengan halaman tujuan
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF2B400),
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 20),

                    // Fingerprint Icon
                    CircleAvatar(
                      backgroundColor: Color(0xFFF2B400).withOpacity(0.2),
                      radius: 25,
                      child: Icon(
                        Icons.fingerprint,
                        size: 30,
                        color: Color(0xFFF2B400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
