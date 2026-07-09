import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'screens/auth/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'ZenFit',
  theme: ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
  ),
  home: const SplashScreen(),
  routes: {
    "/login": (_) => const LoginScreen(),
    "/dashboard": (_) => DashboardScreen(),
  },
);
  }
}
