/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/cubit/qr_cubit.dart';
import 'package:touristapp/ui/widgets/custom_button.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/modal/modal_dialogs.dart';

class QrScannerWidget extends StatefulWidget {
  const QrScannerWidget({super.key});

  @override
  State<QrScannerWidget> createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  final MobileScannerController controller = MobileScannerController();

  final QrCubit _qrCubit = getIt<QrCubit>();

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _qrCubit,
    child: Scaffold(
      body: BlocListener<QrCubit, QrState>(
        listener: (context, state) {
          if (state.qrCheckStatus == .loading) {
            ModalDialogs.showLoader(context);
          } else if (state.qrCheckStatus == .error) {
            ModalDialogs.dismissCurrentDialog();
            ModalDialogs.showErrorDialog(
              context,
              title: state.qrCheckError ?? "",
            );
          } else if (state.qrCheckStatus == .success) {
            ModalDialogs.dismissCurrentDialog();
            // navigation to result screen with state.qrCheckResult
            debugPrint(state.qrCheckResult?.amount.toString());
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(Assets.imagesHomeBg, fit: .cover),
            ),
            SafeArea(
              child: Padding(
                padding: context.k24Padding,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: context.borderRadius16,
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              MobileScanner(
                                controller: controller,
                                onDetect: (capture) {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;

                                  for (final barcode in barcodes) {
                                    final String? value = barcode.rawValue;

                                    if (value != null) {
                                      debugPrint("QR ID: $value");
                                      _qrCubit.checkQr(value);
                                      return;
                                    }
                                  }
                                },
                              ),
                              _ScannerOverlay(),
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
          ],
        ),
      ),
    ),
  );
}

class _ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scanSize = 250.0;

        return Stack(
          children: [
            /// Dark overlay
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                // ignore: deprecated_member_use
                Colors.black.withOpacity(0.1),
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: scanSize,
                      height: scanSize,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// White border frame
            Center(
              child: Container(
                width: scanSize,
                height: scanSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
