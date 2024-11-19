import 'package:flutter/material.dart';

class AppbarUserWidget extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userId;

  const AppbarUserWidget({
    Key? key,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              userId,
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
