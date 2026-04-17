/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeCapture, MobileScanner, MobileScannerController;
import 'package:touristapp/ui/home/main/ui/screens/qr/widgets/scan_animation_widget.dart'
    show ScannerOverlay;

import '../../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;

class QrScanWidget extends StatefulWidget {
  final MobileScannerController controller;
  final void Function(BarcodeCapture barcode) onDetect;
  final bool isLoading;

  const QrScanWidget({
    super.key,
    required this.onDetect,
    required this.controller,
    required this.isLoading,
  });

  @override
  State<QrScanWidget> createState() => _QrScanWidgetState();
}

class _QrScanWidgetState extends State<QrScanWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _cornerAnimationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _cornerScaleAnimation;
  late Animation<double> _cornerOffsetAnimation;
  late Animation<double> _scanLineAnimation;
  late AnimationController animationController;

  @override
  void dispose() {
    _pulseController.dispose();
    _cornerAnimationController.dispose();
    animationController.dispose();
    debugPrint("Disposed QrScanWidget animations");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), // Slower for smoother feel
    );

    // Use a smoother curve
    animationController.repeat(reverse: true);

    // Pulse animation with smoother curve
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOutSine, // Smoother curve
      ),
    );

    // Corner animation with smoother transitions
    _cornerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _cornerScaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(
        parent: _cornerAnimationController,
        curve: Curves.easeInOutCubic, // Very smooth curve
      ),
    );

    _cornerOffsetAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _cornerAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Scan line animation with smooth curve
    _scanLineAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: context.borderRadius16,
    child: Stack(
      children: [
        // Camera view - isolated with RepaintBoundary
        RepaintBoundary(
          child: MobileScanner(
            controller: widget.controller,
            onDetect: widget.onDetect,
          ),
        ),

        // Blur overlay when loading
        Visibility(
          replacement: const SizedBox.shrink(),
          visible: widget.isLoading,
          child: Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: context.borderRadius16,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(color: Colors.black.withAlpha(115)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Scanner overlay with isolated animations
              RepaintBoundary(
                child: ScannerOverlay(
                  isLoading: widget.isLoading,
                  scanLineAnimation: _scanLineAnimation,
                  scanAnimationController: animationController,
                  pulseAnimation: _pulseAnimation,
                  cornerScaleAnimation: _cornerScaleAnimation,
                  cornerOffsetAnimation: _cornerOffsetAnimation,
                  size: context.width * .50,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
