/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;

class CustomButton extends StatefulWidget {
  final Color? bgColor;
  final Color? fgColor;
  final BorderRadius? borderRadius;
  final VoidCallback onPressed;
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;

  final TextStyle? textStyle;

  final BorderSide? borderSide;

  const CustomButton({
    super.key,
    this.bgColor,
    this.borderRadius,
    required this.onPressed,
    this.text,
    this.child,
    this.textStyle,
    this.borderSide,
    this.fgColor, this.width, this.height,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) => SizedBox.fromSize(
    size: Size(widget.width ?? double.infinity, widget.height ?? 56),
    child: ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          backgroundColor: widget.bgColor ?? context.primary,
          foregroundColor: widget.fgColor ?? Colors.white,
          shape: widget.borderRadius != null ?  RoundedRectangleBorder(
            side: widget.borderSide ?? BorderSide.none,
            borderRadius: widget.borderRadius ?? context.borderRadius16,
          ) : StadiumBorder(),
        ),
        onPressed: _handlePressed,
        child: widget.child ?? Text(widget.text ?? "", style: widget.textStyle),
      ),
    ),
  );
}
