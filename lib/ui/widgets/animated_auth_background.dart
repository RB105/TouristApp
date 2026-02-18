import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:lottie/lottie.dart';
import 'package:touristapp/generated/assets.dart' show Assets;

class AnimatedAuthBackground extends StatelessWidget {
  const AnimatedAuthBackground({
    super.key,
    required this.svgAsset,
    this.lottieAsset = Assets.lottiesGlobe,
    this.lottieOpacity = 0.18,
    this.fit = BoxFit.cover,
  });

  final String svgAsset;
  final String lottieAsset;
  final double lottieOpacity;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => MediaQuery.removeViewInsets(
        context: context,
        removeBottom: true,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(svgAsset, fit: fit),
            IgnorePointer(
              child: Opacity(
                opacity: lottieOpacity,
                child: Lottie.asset(
                  lottieAsset,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              ),
            ),
          ],
        ),
      );
}

