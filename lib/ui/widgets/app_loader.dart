/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/color_extension.dart' show ColorExtension;

class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool center;

  const AppLoader({
    super.key,
    this.size = 24,
    this.strokeWidth = 2,
    this.color,
    this.padding,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final loader = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? context.primary,
        ),
      ),
    );

    final padded = padding == null ? loader : Padding(padding: padding!, child: loader);
    return center ? Center(child: padded) : padded;
  }
}

