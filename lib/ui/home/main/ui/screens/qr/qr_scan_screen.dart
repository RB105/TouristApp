/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:touristapp/ui/home/main/logic/model/home_details_result.dart';
import 'package:touristapp/ui/home/main/ui/screens/qr/widgets/qr_image_widget.dart';
import 'package:touristapp/ui/home/main/ui/screens/qr/widgets/qr_scan_widget.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart';
import 'package:touristapp/ui/widgets/asset_svg.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/dialog_ext.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../utils/di/di.dart' show getIt;
import '../../../logic/cubit/qr_cubit.dart';
import '../../../logic/model/qr_check_result.dart' show QrCheckResult;

class QrScanScreen extends StatefulWidget {
  final Wallet wallet;
  final void Function(QrCheckResult qrCheckResult) onResult;

  const QrScanScreen({super.key, required this.onResult, required this.wallet});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final MobileScannerController controller = MobileScannerController(
    autoStart: true,
  );
  bool isTorchEnabled = false;

  late AnimationController animationController;

  final _qrCubit = getIt<QrCubit>();

  bool _isProcessing = false;

  bool _isScan = true;

  @override
  void dispose() {
    controller.dispose();
    debugPrint("QrScanScreen disposed");
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
                        AppAnimatedSwitcher(
                          reverseDuration: const Duration(milliseconds: 700),
                          child: _isScan
                              ? InkWell(
                                  onTap: () {
                                    setState(
                                      () => isTorchEnabled = !isTorchEnabled,
                                    );
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
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    context.szBoxHeight20,
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.primary,
                            borderRadius: context.borderRadius24,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.bgMuted,
                                      borderRadius: context.borderRadius20,
                                    ),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      switchInCurve: Curves.easeOutCubic,
                                      switchOutCurve: Curves.easeInCubic,
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: ScaleTransition(
                                            scale: Tween<double>(
                                              begin: 0.92,
                                              end: 1.0,
                                            ).animate(animation),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: _isScan
                                          ? KeyedSubtree(
                                              key: const ValueKey('scan'),
                                              child: QrScanWidget(
                                                onDetect: (v) {
                                                  if (_isProcessing) return;
                                                  final value =
                                                      v.barcodes.first.rawValue;
                                                  if (value != null) {
                                                    _isProcessing = true;
                                                    _qrCubit.checkQr(value);
                                                  }
                                                },
                                                controller: controller,
                                                isLoading:
                                                    state.qrCheckStatus ==
                                                    .loading,
                                              ),
                                            )
                                          : KeyedSubtree(
                                              key: const ValueKey('image'),
                                              child: QrImageWidget(
                                                wallet: widget.wallet,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: context.k12Padding,
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _isScan = !_isScan),
                                  child: Row(
                                    children: [
                                      AssetSvg(_isScan ? Assets.iconsQr : Assets.iconsScan),
                                      context.szBoxWidth8,
                                      Column(
                                        crossAxisAlignment: .start,
                                        children: [
                                          Text(
                                            _isScan
                                                ? "Show my QR"
                                                : "Scan QR code",
                                            style: context.mediumSm.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            _isScan
                                                ? "Showing QR code to receive funds"
                                                : "Scan a QR code to send funds",
                                            style: context.textXs.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
