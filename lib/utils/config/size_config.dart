import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleWidth;
  static late double scaleHeight;

  static void init(BuildContext context, {double baseWidth = 445, double baseHeight = 964}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    scaleWidth = screenWidth / baseWidth;
    scaleHeight = screenHeight / baseHeight;
  }

  static double w(double width) => width * scaleWidth;

  static double h(double height) => height * scaleHeight;

  static double sp(double fontSize) => fontSize * scaleWidth; // Or average scale
}
