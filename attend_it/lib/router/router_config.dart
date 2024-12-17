import 'package:attend_it/pages/camera_page.dart';
import 'package:attend_it/pages/history_page.dart';
import 'package:attend_it/pages/home_page.dart';
import 'package:attend_it/pages/login_page.dart';
import 'package:attend_it/pages/presensi_page.dart';
import 'package:attend_it/pages/profile_page.dart';
import 'package:attend_it/pages/portal_page.dart';
import 'package:attend_it/pages/register_page.dart';
import 'package:attend_it/pages/reset_password_page.dart';
import 'package:attend_it/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'presensi',
              builder: (context, state) => const PresensiPage(),
              routes: [
                GoRoute(
                  path: 'camera',
                  builder: (context, state) => const CameraPage(),
                ),
              ],
            ),
            GoRoute(
              path: 'histori',
              builder: (context, state) => const HistoryPage(),
            ),
            GoRoute(
              path: 'portal',
              builder: (context, state) => const PortalPage(),
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: '/reset-password',
                  builder: (context, state) => const ResetPasswordPage(),
                ),
              ]
            ),
          ],
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    ),
  ],
);
