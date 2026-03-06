/* September 2025 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;

class PrimaryContainer extends StatefulWidget {
  final List<Widget>? children;
  final double? radius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;

  const PrimaryContainer({
    super.key,
    this.children,
    this.radius,
    this.child,
    this.padding,
    this.bgColor,
  });

  @override
  State<PrimaryContainer> createState() => _PrimaryContainerState();
}

class _PrimaryContainerState extends State<PrimaryContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? 16),
          color: widget.bgColor ?? context.bgElevated,
        ),
        child: Padding(
          padding: widget.padding ?? context.k16Padding,
          child:
              widget.child ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: widget.children ?? [],
              ),
        ),
      ),
    );
  }
}
