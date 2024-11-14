import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30), // Memberikan jarak di bagian atas
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStudentData(),
            Center(
              child: Container(
                width: 330, // Atur lebar Divider sesuai keinginan
                child: Divider(
                  color: Color(0xFF0047AB), // Warna biru kustom
                  thickness: 2,
                ),
              ),
            ),
            _buildRecap(),
            Center(
              child: Container(
                width: 330,
                child: Divider(
                  color: Color(0xFF0047AB),
                  thickness: 2,
                ),
              ),
            ),
            _buildHelpCenter(),
            Center(
              child: Container(
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity, // Menyesuaikan dengan lebar layar
      padding: const EdgeInsets.symmetric(vertical: 30),
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
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/ktm.jpeg'),
          ),
          const SizedBox(height: 15),
          const Text(
            'Kinata Dewa Ariandi',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            '2241720087',
            style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildStudentData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Data Mahasiswa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildDataRow("NIM", "2241720087"),
          _buildDataRow("Kelas", "TI 3B"),
          _buildDataRow("Program Studi", "D-IV Teknik Informatika"),
          _buildDataRow("Jurusan", "Teknologi Informasi"),
        ],
      ),
    );
  }

  Widget _buildRecap() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Rekap",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildDataRow("ALPHA", "0"),
          _buildDataRow("IZIN", "0"),
          _buildDataRow("SAKIT", "12"),
        ],
      ),
    );
  }

  Widget _buildHelpCenter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
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
        children: const [
          Text("Pengaturan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bahasa"),
              Row(
                children: [
                  Text("Indonesia"),
                  Switch(value: false, onChanged: null),
                  Text("English"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("Atur Ulang Kata Sandi"),
          SizedBox(height: 10),
          Text("App Version", style: TextStyle(color: Colors.grey)),
          Text("v.2.3.0"),
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
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
