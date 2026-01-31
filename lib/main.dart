import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart' show SizeConfigInit;
import 'package:touristapp/ui/splash/on_boarding_screen.dart';
import 'package:touristapp/utils/config/size_config.dart';

void main() {
  runApp(const TouristApp());
}

class TouristApp extends StatelessWidget {
  const TouristApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(boldText: false, textScaler: TextScaler.linear(1.0)),
      child: SizeConfigInit(
        referenceHeight: 874,
        referenceWidth: 402,
        builder: (ctx, _) {
          SizeConfig.init(ctx);
          return MaterialApp(
            themeAnimationStyle: AnimationStyle(
              curve: Curves.easeInOutCubicEmphasized,
              duration: Duration(milliseconds: 650),
              reverseDuration: Duration(milliseconds: 500),
            ),
            themeAnimationDuration: const Duration(milliseconds: 650),
            title: 'Tourist App',
            debugShowCheckedModeBanner: false,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
