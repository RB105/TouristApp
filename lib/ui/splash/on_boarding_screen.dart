/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart';

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
                    child: SvgPicture.asset(Assets.iconsAppLogo10032),
                  ),
                  SizedBox(height: 16.0),
                  TouristTicker(),
                  Spacer(),
                  Stack(
                    children: [
                      Lottie.asset(
                        Assets.lottiesGlobe,
                        height: 300,
                        width: 400,
                        fit: BoxFit.contain,
                      ),
                      Stack(
                        children: [
                          Lottie.asset(
                            Assets.lottiesGlobe,
                            height: 300,
                            width: 400,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "One wallet. No limits.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Global transfers, payments made simple.",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff401CE2)),
                                    onPressed: () {},
                                    child: Text("Get started",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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

class TouristTicker extends StatefulWidget {
  const TouristTicker({super.key});

  @override
  State<TouristTicker> createState() => _TouristTickerState();
}

class _TouristTickerState extends State<TouristTicker> {
  // Your specific list of texts and icons
  final List<Map<String, dynamic>> _items = [
    {'text': 'Cashback & bonuses', 'icon': Assets.iconsTextBonus},
    {'text': 'Safe with you', 'icon': Assets.iconsTextSafe},
    {'text': 'World-wide usage', 'icon': Assets.iconsTextGlobe},
    {'text': 'Fast money transfers', 'icon': Assets.iconsTextCard},
    {'text': 'All in one wallet', 'icon': Assets.iconsTextWallet},
    {'text': 'Fast QR payments', 'icon': Assets.iconsTextQr},
  ];

  late FixedExtentScrollController _controller;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();

    // Start the auto-scroll timer
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _currentIndex = (_currentIndex + 1) % _items.length;
      _controller.animateToItem(
        _currentIndex,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: 50,
        // Height of each row
        physics: NeverScrollableScrollPhysics(),
        perspective: 0.00001,
        // Flat look like your video
        onSelectedItemChanged: (index) {
          setState(() => _currentIndex = index % _items.length);
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: _items.map((item) {
            bool isActive =
                _items.indexOf(item) == (_currentIndex % _items.length);
            return Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              children: [
                // Icon/Emoji
                AppAnimatedSwitcher(
                  reverseDuration: Duration(milliseconds: 100),
                  child: isActive
                      ? Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Center(
                                child: SvgPicture.asset(item['icon']),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                Text(
                  item['text'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                    color: isActive ? Colors.black : Colors.black26,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
