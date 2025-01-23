import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void validate(AuthProvider auth) {
    Timer(Duration(seconds: 1), () {
      auth.RefreshToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, auth, child) {
        validate(auth);
        return Center(
          child: Image.asset("assets/icons/logo.png"),
        );
      }),
    );
  }
}
