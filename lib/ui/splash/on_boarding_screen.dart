/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/auth/view/auth_screen.dart';
import 'package:touristapp/ui/splash/widgets/tourist_ticker.dart' show TouristTicker;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(Assets.imagesState1),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 32,
                    child: SvgPicture.asset(Assets.iconsAppLogo100X32Blue),
                  ),
                  const SizedBox(height: 16.0),
                  TouristTicker(),
                  const SizedBox(height: 12.0),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final globeHeight = constraints.maxHeight * 0.65;
                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Lottie.asset(
                                Assets.lottiesGlobe,
                                height: globeHeight,
                                width: constraints.maxWidth,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "One wallet. No limits.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Global transfers, payments made simple.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff401CE2),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AuthScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Get started",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}