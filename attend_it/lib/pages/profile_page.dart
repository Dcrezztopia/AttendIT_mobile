import 'package:attend_it/provider/auth_provider.dart';
import 'package:attend_it/provider/statistics_provider.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  int _currentIndex = 4;

  void _logout() async {
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.logout();
    print('User has logged out successfully');
    // ignore: use_build_context_synchronously
    context.go('/login');
  }

  @override
  void initState() {
    super.initState();
    // Fetch statistics data when the page is initialized
    Future.microtask(
        () => ref.read(statisticsProvider.notifier).fetchStatistics());
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final mahasiswa = authState.mahasiswa;
    final statistics = ref.watch(statisticsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(mahasiswa),
            const SizedBox(height: 20),
            _buildStudentData(mahasiswa),
            const Center(
              child: SizedBox(
                width: 330, // Atur lebar Divider sesuai keinginan
                child: Divider(
                  color: Color(0xFF0047AB), // Warna biru kustom
                  thickness: 2,
                ),
              ),
            ),
            _buildRecap(statistics),
            const Center(
              child: SizedBox(
                width: 330,
                child: Divider(
                  color: Color(0xFF0047AB),
                  thickness: 2,
                ),
              ),
            ),
            _buildHelpCenter(),
            const Center(
              child: SizedBox(
                width: 330,
                child: Divider(
                  color: Color(0xFF0047AB),
                  thickness: 2,
                ),
              ),
            ),
            _buildSettings(),
          ],
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

  Widget _buildHeader(Map<String, dynamic>? mahasiswa) {
    return Container(
      width: double.infinity, // Menyesuaikan dengan lebar layar
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: const BoxDecoration(
        color: Color(0xFF0C4DA2),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/ktm.jpeg'),
          ),
          const SizedBox(height: 15),
          Text(
            mahasiswa != null ? mahasiswa['nama_mahasiswa'] : 'Nama Mahasiswa',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            mahasiswa != null ? mahasiswa['nim'] : 'NIM',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const Text(
            '\nJurusan Teknologi Informasi\nPoliteknik Negeri Malang',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentData(Map<String, dynamic>? mahasiswa) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Data Mahasiswa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildDataRow("NIM", mahasiswa != null ? mahasiswa['nim'] : 'NIM'),
          _buildDataRow(
              "Kelas", mahasiswa != null ? mahasiswa['nama_kelas'] : 'Kelas'),
          _buildDataRow("Program Studi",
              mahasiswa != null ? mahasiswa['prodi'] : 'Program Studi'),
          _buildDataRow("Jurusan", "Teknologi Informasi"),
        ],
      ),
    );
  }

  Widget _buildRecap(Map<String, int> statistics) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Rekap",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // _buildDataRow("Hadir", statistics['hadir'].toString()),
          _buildDataRow("Alpha", statistics['alpha'].toString()),
          _buildDataRow("Izin", statistics['izin'].toString()),
          _buildDataRow("Sakit", statistics['sakit'].toString()),
        ],
      ),
    );
  }

  Widget _buildHelpCenter() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pusat Bantuan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Bantuan"),
          SizedBox(height: 5),
          Text("Laporkan Masalah"),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pengaturan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Atur Ulang Kata Sandi"),
          const SizedBox(height: 10),
          const Text("App Version", style: TextStyle(color: Colors.grey)),
          const Text("beta"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Background color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDataRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
