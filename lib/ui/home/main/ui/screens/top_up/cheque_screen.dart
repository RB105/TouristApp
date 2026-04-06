/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:io' show File;
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, XFile, ShareParams;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/router/app_router.dart';

import '../../../../../../generated/assets.dart' show Assets;
import '../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../../utils/extensions/primary_decoration_ext.dart';
import '../../../../../widgets/slide_fade_in.dart' show SlideFadeIn;

class ChequeScreen extends StatefulWidget {
  final String? extId;

  const ChequeScreen({super.key, this.extId});

  static const String routeName = '/cheque';

  @override
  State<ChequeScreen> createState() => _ChequeScreenState();
}

class _ChequeScreenState extends State<ChequeScreen> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("transfer.cheque.tr_details".tr()),
      ),
      body: SlideFadeIn(
        child: Padding(
          padding: context.k16horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: double.infinity,
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: SizedBox(
                        child: DecoratedBox(
                          decoration: context.decoration,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.bgMain,
                            ),
                            onPressed: () => _takeAndShareScreenshot(),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    Assets.iconsMedia,
                                    colorFilter: ColorFilter.mode(
                                      context.bgMain,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                context.szBoxWidth4,
                                Text(
                                  "monitoring.share".tr(),
                                  style: context.semiboldMd.copyWith(
                                    color: context.bgMain,
                                  ),
                                ), // podelitsya
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    context.szBoxWidth12,
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          MainRoute().go(context);
                        },
                        child: Text(
                          "monitoring.close".tr(),
                          style: context.semiboldMd.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                context.szNavbarHeight,
            ],
          ),
        ),
      )
    );
  }

  Future<void> _takeAndShareScreenshot() async {
    try {
      final Uint8List? capturedImage = await _screenshotController.capture();
      if (capturedImage != null) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/$tr.png';
        final file = File(filePath);
        await file.writeAsBytes(capturedImage);
        await SharePlus.instance.share(ShareParams(files: [XFile(filePath)]));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _getStateMethod() async {
    // switch (tr?.type) {
    //   case 4:
    //     _transferCubit.checkTcbTransferState(tr?.trId ?? "");
    //     break;
    //   case 1:
    //     _transferCubit.checkSbpQrTransferState(tr?.trId ?? "");
    //     break;
    // }
  }
}
