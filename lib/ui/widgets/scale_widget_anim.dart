/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

class ScaleWidgetAnim extends StatefulWidget {
  final Widget child;

  const ScaleWidgetAnim({super.key, required this.child});

  @override
  State<ScaleWidgetAnim> createState() => _ScaleWidgetAnimState();
}

class _ScaleWidgetAnimState extends State<ScaleWidgetAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ScaleTransition(scale: _scaleAnimation, child: widget.child);
}
