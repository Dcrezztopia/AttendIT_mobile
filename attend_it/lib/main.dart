import 'package:attend_it/pages/camera_page.dart';
import 'package:attend_it/pages/history_page.dart';
import 'package:attend_it/pages/home_page.dart';
import 'package:attend_it/pages/login_page.dart';
import 'package:attend_it/pages/presensi_page.dart';
import 'package:attend_it/pages/profile_page.dart';
import 'package:attend_it/pages/schedule_page.dart';
import 'package:attend_it/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attend_it/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).tryAutoLogin();
    });
    _router = GoRouter(
      initialLocation: '/',
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
        ),
        GoRoute(
          path: '/presensi',
          builder: (context, state) => const PresensiPage(),
        ),
        GoRoute(
          path: '/histori',
          builder: (context, state) => const HistoryPage(),
        ),
        GoRoute(
          path: '/schedule',
          builder: (context, state) => const SchedulePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/camera',
          builder: (context, state) => const CameraPage(),
        ),
      ],
      // redirect: (context, state) {
      //   final authState = ref.read(authProvider);
      //   // Redirect to login if not authenticated and trying to access a restricted page
      //   final isAuthenticated = authState.isAuthenticated;
      //   print(isAuthenticated);
      //   final isLoading = authState.isLoading;
      //   final isLoggingIn = state.uri.toString() == '/login';

      //   if (isLoading) {
      //     context.go('/');
      //   }

      //   if (!isAuthenticated && !isLoggingIn) {
      //     context.go('/login');
      //   }

      //   if (isAuthenticated && isLoggingIn) {
      //     context.go('/home');
      //   }

      //   return null;
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Attend IT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
