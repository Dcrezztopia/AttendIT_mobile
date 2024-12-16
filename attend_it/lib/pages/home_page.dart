// pages/home_page.dart
import 'package:attend_it/provider/auth_provider.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    // print('HomePage: Mahasiswa = ${authState.mahasiswa}');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// USER SECTION
              const SizedBox(height: 60),
              const Text(
                'Selamat Datang,',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0047AB)),
              ),
              Text(
                authState.mahasiswa != null
                    ? authState.mahasiswa!['nama_mahasiswa']
                    : 'Pengguna',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0047AB)),
              ),
              const SizedBox(height: 60),

              /// FAST MENU IN HOMEPAGE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom pertama: Lihat Jadwal dan History
                  Expanded(
                    child: Column(
                      children: [
                        _buildMenuItem(
                          SizedBox(
                            width: 100,
                            height: 90,
                            child: Image.asset('assets/images/jadwalHome.png'),
                          ),
                          'Portal Akademik',
                          Colors.white,
                          isGradient: true,
                          gradientColors: [
                            Colors.green[800]!,
                            Colors.green[300]!
                          ],
                          onTap: () {
                            context.go('/home/portal');
                          },
                        ),
                        const SizedBox(height: 32), // Jarak antar item
                        _buildMenuItem(
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.asset('assets/images/historyHome.png'),
                          ),
                          'History',
                          Colors.white,
                          isGradient: true,
                          gradientColors: [
                            Colors.blue[800]!,
                            Colors.blue[300]!
                          ],
                          onTap: () {
                            context.go('/home/histori');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Jarak antar kolom

                  // Kolom kedua: Presensi dan Profile
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        _buildMenuItem(
                          SizedBox(
                            width: 100,
                            height: 100,
                            child:
                                Image.asset('assets/images/presensiHome.png'),
                          ),
                          'Presensi',
                          Colors.white,
                          isGradient: true,
                          gradientColors: [
                            const Color(0xFF9B29F1),
                            const Color(0xFFDBB0FD),
                          ],
                          onTap: () {
                            context.go('/home/presensi');
                          },
                        ),
                        const SizedBox(height: 32), // Jarak antar item
                        _buildMenuItem(
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/images/profileHome.png'),
                          ),
                          'Profile',
                          Colors.white,
                          isGradient: true,
                          gradientColors: [
                            Colors.orange[800]!,
                            Colors.orange[300]!
                          ],
                          onTap: () {
                            context.go('/home/profile');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  BoxDecoration createGradient(List<Color> colors) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(40.0),
    );
  }

  Widget _buildMenuItem(
    Widget icon,
    String title,
    Color color, {
    bool isGradient = false,
    List<Color>? gradientColors,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 200, // Atur tinggi sesuai keinginan
        child: Container(
          decoration: isGradient && gradientColors != null
              ? BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(40),
                )
              : BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon, // Gambar atau ikon yang digunakan
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
