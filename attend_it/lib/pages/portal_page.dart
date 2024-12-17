import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/appbar_user_widget.dart';
import '../widgets/bottom_nav_widget.dart';

class PortalPage extends ConsumerStatefulWidget {
  const PortalPage({super.key});

  @override
  PortalPageState createState() => PortalPageState();
}

class PortalPageState extends ConsumerState<PortalPage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarUserWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Portal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Grid layout untuk fitur-fitur
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  FeatureWidget(
                    title: "Siakad",
                    gradientColors: [
                      Color(0xFF9B29F1),
                      Color.fromARGB(255, 196, 136, 239),
                    ],
                    url: "https://siakad.polinema.ac.id/login/",
                    imagePath: 'assets/images/siakad.png',
                  ),
                  FeatureWidget(
                    title: "LMS",
                    gradientColors: [
                      Color(0xFFFCCF31),
                      Color(0xFFF55555),
                    ],
                    url: "https://lmsslc.polinema.ac.id/",
                    imagePath: 'assets/images/jadwal2.png',
                  ),
                  FeatureWidget(
                    title: "Website JTI",
                    gradientColors: [
                      Color(0xFFFF3F3B),
                      Color(0xFFF97A7E),
                    ],
                    url: "https://jti.polinema.ac.id/",
                    imagePath: 'assets/images/web.png',
                  ),
                  FeatureWidget(
                    title: "Website Polinema",
                    gradientColors: [
                      Color(0xFF30A9FF),
                      Color(0xFF6CD9FF),
                    ],
                    url: "https://www.polinema.ac.id/",
                    imagePath: 'assets/images/lms.png',
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
