import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/appbar_user_widget.dart';
import '../widgets/bottom_nav_widget.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarUserWidget(),
      body: Column(
        children: [
          const FeatureWidget(
            title: "Jadwal",
            gradientColors: [
              Color.fromARGB(255, 73, 89, 208),
              Color.fromARGB(255, 255, 255, 255),
            ],
            imagePath: 'assets/images/jadwal2.png',
          ),
          const FeatureWidget(
            title: "Siakad",
            gradientColors: [
              Color(0XFFFFA4ED),
              Color.fromARGB(255, 255, 255, 255),
            ],
            url: "https://siakad.polinema.ac.id/login/",
            imagePath: 'assets/images/siakad.png',
          ),
          const FeatureWidget(
            title: "LMS",
            gradientColors: [
              Color.fromARGB(255, 237, 172, 80),
              Color.fromARGB(255, 255, 255, 255),
            ],
            url: "https://lmsslc.polinema.ac.id/",
            imagePath: 'assets/images/lms.png',
          ),
          const FeatureWidget(
            title: "Website JTI",
            gradientColors: [
              Color(0XFFFF3F3B),
              Color.fromARGB(255, 255, 255, 255),
            ],
            url: "https://jti.polinema.ac.id/",
            imagePath: 'assets/images/web.png',
          ),
          Expanded(
            child: Container(), // Placeholder untuk mengisi ruang kosong
          ),
        ],
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
}

class FeatureWidget extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  final String? url; // Tambahkan parameter URL
  final String? imagePath; // Tambahkan parameter imagePath

  const FeatureWidget({
    super.key,
    required this.title,
    required this.gradientColors,
    this.url, // URL optional
    this.imagePath, // imagePath optional
  });

  // Fungsi untuk membuka URL menggunakan launchUrl
  Future<void> _launchURL(BuildContext context) async {
    if (url != null) {
      // Tampilkan pop-up konfirmasi menggunakan AlertDialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/giphy.gif',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Open Link?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Do you want to open this link?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final Uri uri = Uri.parse(url!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Could not launch $url';
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: url != null ? () => _launchURL(context) : null,
      child: Container(
        width: 380,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (imagePath != null)
              Positioned(
                top: 20,
                right: 10,
                child: Image.asset(
                  imagePath!,
                  width: 90,
                  height: 90,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
