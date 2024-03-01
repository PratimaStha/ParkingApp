import 'package:flutter/material.dart';
import 'package:flutter_parking/core/development/console.dart';
import 'package:flutter_parking/core/routing/route_navigation.dart';
import 'package:flutter_parking/pages/auth/login/login_screen.dart';
import 'package:flutter_parking/pages/homepage.dart';
import 'package:flutter_parking/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      SharedPref.getToken() != null
          ? navigateOffAll(context, const HomePage())
          : navigateOffAll(context, const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    consolelog(SharedPref.getToken());
    return Scaffold(
      body: Container(),
    );
  }
}
