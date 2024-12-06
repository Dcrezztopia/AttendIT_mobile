import 'package:attend_it/widgets/bottom_nav_widget.dart';
import 'package:attend_it/widgets/appbar_user_widget.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05), // Memberikan jarak di bagian atas
            _buildHeader(width),
            SizedBox(height: height * 0.02),
            _buildStudentData(),
            _buildDivider(width),
            _buildRecap(),
            _buildDivider(width),
            _buildHelpCenter(),
            _buildDivider(width),
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

  Widget _buildHeader(double width) {
    return Align(
      alignment: Alignment.topCenter, // Mengatur posisi ke atas
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: width * 0.08,
        ),
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
      child: const Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/ktm.jpeg'),
          ),
          SizedBox(height: 15),
          Text(
            'Kinata Dewa Ariandi',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '2241720087',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            '\nJurusan Teknologi Informasi\nPoliteknik Negeri Malang',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pengaturan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(height: 10),
          Text("Atur Ulang Kata Sandi"),
          SizedBox(height: 10),
          Text("App Version", style: TextStyle(color: Colors.grey)),
          Text("beta"),
        ],
      ),
    );
  }

  Widget _buildDataRow(String title, String value) {
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

  Widget _buildDivider(double width) {
    return Center(
      child: SizedBox(
        width: width * 0.8, // Atur lebar Divider sesuai lebar layar
        child: const Divider(
          color: Color(0xFF0047AB),
          thickness: 2,
        ),
      ),
    );
  }
}
