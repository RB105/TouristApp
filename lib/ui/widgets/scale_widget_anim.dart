/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

class ScaleWidgetAnim extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const ScaleWidgetAnim({super.key, required this.child, required this.onPressed});

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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.75).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed.call();
  }

  @override
  Widget build(BuildContext context) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: _handlePressed,
    child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
  );
}
