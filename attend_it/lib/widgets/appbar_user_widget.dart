import 'package:attend_it/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppbarUserWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final mahasiswa = authState.mahasiswa;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mahasiswa != null ? mahasiswa['nama_mahasiswa'] : 'Nama Mahasiswa',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              mahasiswa != null ? mahasiswa['nim'] : 'NIM',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(199, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF0047AB),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75.0);
}
