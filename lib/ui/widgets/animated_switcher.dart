/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

class AppAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  const AppAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.reverseDuration = const Duration(milliseconds: 100)
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: curve,
      child: AnimatedSwitcher(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: curve,
        switchOutCurve: curve,
        transitionBuilder: (child, animation) {
          final slideTween = Tween<Offset>(
            begin: const Offset(0.0, -0.2),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: curve,
          ));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: slideTween,
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
