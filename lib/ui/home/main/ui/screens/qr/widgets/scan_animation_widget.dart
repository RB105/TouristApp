/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

// ============== Scanner Overlay Widget ==============
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({
    super.key,
    required this.isLoading,
    required this.scanLineAnimation,
    required this.scanAnimationController,
    required this.pulseAnimation,
    required this.cornerScaleAnimation,
    required this.cornerOffsetAnimation,
    required this.size,
  });

  final bool isLoading;
  final Animation<double> scanLineAnimation;
  final AnimationController scanAnimationController;
  final Animation<double> pulseAnimation;
  final Animation<double> cornerScaleAnimation;
  final Animation<double> cornerOffsetAnimation;
  final double size;

  @override
  Widget build(BuildContext context) {
    final cornerLength = size * 0.18;
    const cornerWidth = 4.0;
    final cornerRadius = 16.sp;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Animated corner brackets - each in its own RepaintBoundary
          RepaintBoundary(
            child: _AnimatedCorner(
              position: CornerPosition.topLeft,
              cornerLength: cornerLength,
              cornerWidth: cornerWidth,
              cornerRadius: cornerRadius,
              scaleAnimation: cornerScaleAnimation,
              offsetAnimation: cornerOffsetAnimation,
              pulseAnimation: pulseAnimation,
              isLoading: isLoading,
            ),
          ),
          RepaintBoundary(
            child: _AnimatedCorner(
              position: CornerPosition.topRight,
              cornerLength: cornerLength,
              cornerWidth: cornerWidth,
              cornerRadius: cornerRadius,
              scaleAnimation: cornerScaleAnimation,
              offsetAnimation: cornerOffsetAnimation,
              pulseAnimation: pulseAnimation,
              isLoading: isLoading,
            ),
          ),
          RepaintBoundary(
            child: _AnimatedCorner(
              position: CornerPosition.bottomLeft,
              cornerLength: cornerLength,
              cornerWidth: cornerWidth,
              cornerRadius: cornerRadius,
              scaleAnimation: cornerScaleAnimation,
              offsetAnimation: cornerOffsetAnimation,
              pulseAnimation: pulseAnimation,
              isLoading: isLoading,
            ),
          ),
          RepaintBoundary(
            child: _AnimatedCorner(
              position: CornerPosition.bottomRight,
              cornerLength: cornerLength,
              cornerWidth: cornerWidth,
              cornerRadius: cornerRadius,
              scaleAnimation: cornerScaleAnimation,
              offsetAnimation: cornerOffsetAnimation,
              pulseAnimation: pulseAnimation,
              isLoading: isLoading,
            ),
          ),

          // Scan line with trail - isolated
          if (!isLoading)
            RepaintBoundary(
              child: _ScanLine(
                scanLineAnimation: scanLineAnimation,
                scanAnimationController: scanAnimationController,
                pulseAnimation: pulseAnimation,
                size: size,
              ),
            ),

          // Grid pattern overlay - static
          if (!isLoading) _GridOverlay(size: size),

          // Loading indicator
          if (isLoading) const _LoadingIndicator(),
        ],
      ),
    );
  }
}

// ============== Corner Position Enum ==============
enum CornerPosition { topLeft, topRight, bottomLeft, bottomRight }

// ============== Animated Corner Widget ==============
class _AnimatedCorner extends StatelessWidget {
  const _AnimatedCorner({
    required this.position,
    required this.cornerLength,
    required this.cornerWidth,
    required this.cornerRadius,
    required this.scaleAnimation,
    required this.offsetAnimation,
    required this.pulseAnimation,
    required this.isLoading,
  });

  final CornerPosition position;
  final double cornerLength;
  final double cornerWidth;
  final double cornerRadius;
  final Animation<double> scaleAnimation;
  final Animation<double> offsetAnimation;
  final Animation<double> pulseAnimation;
  final bool isLoading;

  Alignment get _alignment {
    switch (position) {
      case CornerPosition.topLeft:
        return Alignment.topLeft;
      case CornerPosition.topRight:
        return Alignment.topRight;
      case CornerPosition.bottomLeft:
        return Alignment.bottomLeft;
      case CornerPosition.bottomRight:
        return Alignment.bottomRight;
    }
  }

  Offset _getOffset(double value) {
    switch (position) {
      case CornerPosition.topLeft:
        return Offset(-value, -value);
      case CornerPosition.topRight:
        return Offset(value, -value);
      case CornerPosition.bottomLeft:
        return Offset(-value, value);
      case CornerPosition.bottomRight:
        return Offset(value, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        scaleAnimation,
        offsetAnimation,
        pulseAnimation,
      ]),
      builder: (context, child) {
        final offset = _getOffset(offsetAnimation.value);

        return Align(
          alignment: _alignment,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: scaleAnimation.value,
              alignment: _alignment,
              child: child,
            ),
          ),
        );
      },
      child: CustomPaint(
        size: Size(cornerLength + cornerWidth, cornerLength + cornerWidth),
        painter: _SingleCornerPainter(
          position: position,
          cornerLength: cornerLength,
          strokeWidth: cornerWidth,
          radius: cornerRadius,
          color: Colors.white,
          glowOpacity: isLoading ? 0.3 : pulseAnimation.value,
          repaint: pulseAnimation,
        ),
      ),
    );
  }
}

// ============== Single Corner Painter ==============
class _SingleCornerPainter extends CustomPainter {
  _SingleCornerPainter({
    required this.position,
    required this.cornerLength,
    required this.strokeWidth,
    required this.radius,
    required this.color,
    required this.glowOpacity,
    required Animation<double> repaint,
  }) : super(repaint: repaint);

  final CornerPosition position;
  final double cornerLength;
  final double strokeWidth;
  final double radius;
  final Color color;
  final double glowOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = color.withAlpha((glowOpacity * 255).toInt())
      ..strokeWidth = strokeWidth + 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = _buildPath(size);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  Path _buildPath(Size size) {
    final path = Path();
    final offset = strokeWidth / 2;

    switch (position) {
      case CornerPosition.topLeft:
        path.moveTo(offset, cornerLength);
        path.lineTo(offset, radius + offset);
        path.quadraticBezierTo(offset, offset, radius + offset, offset);
        path.lineTo(cornerLength, offset);
        break;

      case CornerPosition.topRight:
        path.moveTo(size.width - cornerLength, offset);
        path.lineTo(size.width - radius - offset, offset);
        path.quadraticBezierTo(
          size.width - offset,
          offset,
          size.width - offset,
          radius + offset,
        );
        path.lineTo(size.width - offset, cornerLength);
        break;

      case CornerPosition.bottomLeft:
        path.moveTo(offset, size.height - cornerLength);
        path.lineTo(offset, size.height - radius - offset);
        path.quadraticBezierTo(
          offset,
          size.height - offset,
          radius + offset,
          size.height - offset,
        );
        path.lineTo(cornerLength, size.height - offset);
        break;

      case CornerPosition.bottomRight:
        path.moveTo(size.width - cornerLength, size.height - offset);
        path.lineTo(size.width - radius - offset, size.height - offset);
        path.quadraticBezierTo(
          size.width - offset,
          size.height - offset,
          size.width - offset,
          size.height - radius - offset,
        );
        path.lineTo(size.width - offset, size.height - cornerLength);
        break;
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant _SingleCornerPainter oldDelegate) {
    return oldDelegate.glowOpacity != glowOpacity ||
        oldDelegate.color != color ||
        oldDelegate.cornerLength != cornerLength;
  }
}

// ============== Scan Line Widget ==============
class _ScanLine extends StatelessWidget {
  const _ScanLine({
    required this.scanLineAnimation,
    required this.scanAnimationController,
    required this.pulseAnimation,
    required this.size,
  });

  final Animation<double> scanLineAnimation;
  final AnimationController scanAnimationController;
  final Animation<double> pulseAnimation;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scanLineAnimation,
      builder: (context, child) {
        const double padding = 20.0;
        final double range = size - padding * 2;
        final double linePosition = padding + scanLineAnimation.value * range;
        final bool movingDown =
            scanAnimationController.status == AnimationStatus.forward;

        return Stack(
          children: [
            // Trail effect with gradient
            Positioned(
              top: movingDown ? linePosition - 60 : linePosition + 3,
              left: 16,
              right: 16,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: movingDown
                        ? Alignment.bottomCenter
                        : Alignment.topCenter,
                    end: movingDown
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(77), // 0.3 * 255
                      Colors.white.withAlpha(0),
                    ],
                  ),
                ),
              ),
            ),
            // Main scan line
            Positioned(
              top: linePosition,
              left: 16,
              right: 16,
              child: AnimatedBuilder(
                animation: pulseAnimation,
                builder: (context, _) {
                  return Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withAlpha(0),
                          Colors.white.withAlpha(180),
                          Colors.white,
                          Colors.white.withAlpha(180),
                          Colors.white.withAlpha(0),
                        ],
                        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withAlpha(
                            (pulseAnimation.value * 255).toInt(),
                          ),
                          // full opacity based on animation
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white.withAlpha(
                            (pulseAnimation.value * 204).toInt(),
                          ),
                          // 0.8 max opacity
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============== Grid Overlay Widget ==============
class _GridOverlay extends StatelessWidget {
  const _GridOverlay({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomPaint(
          size: Size(size, size),
          painter: _GridPatternPainter(
            color: Colors.white.withAlpha(38), // 0.15 * 255
          ),
          isComplex: true,
          willChange: false,
        ),
      ),
    );
  }
}

// ============== Loading Indicator Widget ==============
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(77),
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        ),
      ),
    );
  }
}

// ============== Grid Pattern Painter ==============
class _GridPatternPainter extends CustomPainter {
  _GridPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    const spacing = 20.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
