import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vidgencraft/core/utils/windows.dart';
import '../../../config/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background to transparent or a color that matches your design
      backgroundColor: Colors.transparent, // or Theme.of(context).colorScheme.background
      body: Container(
        // Optional: Add a gradient or solid color background
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background, // Fallback background
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/robo.gif', // Your GIF path
                width: Window.getSize(350), // Responsive width
                height: Window.getSize(350), // Responsive height
                fit: BoxFit.contain, // Ensure GIF scales properly
                // Optional: Add a filter to handle transparency
                colorBlendMode: BlendMode.dst, // Preserve transparency
              ),
            ],
          ),
        ),
      ),
    );
  }
}