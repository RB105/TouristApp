/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:touristapp/ui/home/main/ui/screens/qr/widgets/scan_animation_widget.dart'
    show ScannerOverlay;
import 'package:touristapp/ui/widgets/asset_svg.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/dialog_ext.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../utils/di/di.dart' show getIt;
import '../../../../../widgets/custom_button.dart' show CustomButton;
import '../../../logic/cubit/qr_cubit.dart';
import '../../../logic/model/qr_check_result.dart' show QrCheckResult;

class QrScanWidget extends StatefulWidget {
  final void Function(QrCheckResult qrCheckResult) onResult;
  const QrScanWidget({super.key, required this.onResult});

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

  final MobileScannerController controller = MobileScannerController(
    autoStart: true,
  );
  bool isTorchEnabled = false;

  late AnimationController animationController;

  final _qrCubit = getIt<QrCubit>();

  bool _isProcessing = false;

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
  void dispose() {
    controller.dispose();

    animationController.dispose();
    _pulseController.dispose();
    _cornerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _qrCubit,
    child: Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(Assets.imagesHomeBg, fit: .cover),
          ),
          BlocConsumer<QrCubit, QrState>(
            listener: (context, state) async {
              if (state.qrCheckStatus == .error) {
                await context
                    .showErrorDialog(title: state.qrCheckError.toString())
                    .then((value) => _isProcessing = false);
              } else if (state.qrCheckStatus == .success) {
                widget.onResult(state.qrCheckResult!);
                context.pop();
              }
            },
            builder: (context, state) => SafeArea(
              child: Padding(
                padding: context.k16Padding,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          child: Row(
                            children: [
                              Icon(Icons.close, color: context.textLink),
                              context.szBoxWidth4,
                              Text(
                                "Close",
                                style: context.textMd.copyWith(
                                  color: context.textLink,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() => isTorchEnabled = !isTorchEnabled);
                            controller.toggleTorch();
                          },
                          child: Row(
                            children: [
                              Text("Flashlight", style: context.textMd),
                              context.szBoxWidth4,
                              AssetSvg(
                                Assets.iconsFlashLight,
                                color: isTorchEnabled
                                    ? context.success
                                    : context.textMain,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    context.szBoxHeight20,
                    Expanded(
                      child: ClipRRect(
                        borderRadius: context.borderRadius16,
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              // Camera view - isolated with RepaintBoundary
                              RepaintBoundary(
                                child: MobileScanner(
                                  controller: controller,
                                  onDetect: (v) {
                                    if (_isProcessing) return;
                                    final value = v.barcodes.first.rawValue;
                                    if (value != null) {
                                      _isProcessing = true;
                                      _qrCubit.checkQr(value);
                                    }
                                  },
                                ),
                              ),

                              // Blur overlay when loading
                              Visibility(
                                replacement: const SizedBox.shrink(),
                                visible: state.qrCheckStatus == .loading,
                                child: Positioned.fill(
                                  child: RepaintBoundary(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 7,
                                        sigmaY: 7,
                                      ),
                                      child: Container(
                                        color: Colors.black.withAlpha(115),
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
                                        isLoading:
                                            state.qrCheckStatus == .loading,
                                        scanLineAnimation: _scanLineAnimation,
                                        scanAnimationController:
                                            animationController,
                                        pulseAnimation: _pulseAnimation,
                                        cornerScaleAnimation:
                                            _cornerScaleAnimation,
                                        cornerOffsetAnimation:
                                            _cornerOffsetAnimation,
                                        size: context.width * .50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    context.szBoxHeight8,
                    CustomButton(onPressed: () {}, text: "Show My Qr"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
