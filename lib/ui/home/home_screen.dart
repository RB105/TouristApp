/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart' show Assets;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MediaQuery.removeViewInsets(
              context: context,
              removeBottom: true,
              child: SvgPicture.asset(Assets.imagesHomeBg, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
