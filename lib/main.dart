import 'package:flutter/material.dart';
import 'package:touristapp/ui/splash/on_boarding_screen.dart';
import 'package:touristapp/ui/splash/splash_screen.dart';

void main() {
  runApp(const TouristApp());
}

class TouristApp extends StatelessWidget {
  const TouristApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
