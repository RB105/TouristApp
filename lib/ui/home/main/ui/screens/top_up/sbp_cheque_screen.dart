/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:io' show File;
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, XFile, ShareParams;
import 'package:touristapp/ui/home/main/logic/cubit/carusel/carusel_cubit.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/widgets/cheque_loading_skeleton.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/widgets/cheque_state_container.dart';
import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/enums/api_status.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/router/app_router.dart';

import '../../../../../../generated/assets.dart' show Assets;
import '../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../widgets/custom_button.dart' show CustomButton;
import '../../../../../widgets/primary_container.dart' show PrimaryContainer;
import '../../../../../widgets/slide_fade_in.dart' show SlideFadeIn;

class SbpChequeScreen extends StatefulWidget {
  final String extId;

  const SbpChequeScreen({super.key, required this.extId});

  static const String routeName = '/sbp-cheque';

  @override
  State<SbpChequeScreen> createState() => _SbpChequeScreenState();
}

class _SbpChequeScreenState extends State<SbpChequeScreen> {
  final _screenshotController = ScreenshotController();

  final _caruselCubit = getIt<CaruselCubit>();

  @override
  void initState() {
    _caruselCubit.getTransactionState(widget.extId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _caruselCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: false,
          title: Text("transfer.tr_details".tr()),
        ),
        body: BlocBuilder<CaruselCubit, CaruselState>(
          builder: (context, state) {
            if (state.transactionStateStatus == ApiStatus.loading &&
                state.transactionState == null) {
              return const ChequeLoadingSkeleton();
            } else if (state.transactionStateStatus == .error) {
              return SizedBox();
            } else if (state.transactionStateStatus == .success ||
                state.transactionState != null) {
              final transaction = state.transactionState ?? MonitoringHistory();
              return SlideFadeIn(
                child: Padding(
                  padding: context.k16Padding,
                  child: Column(
                    crossAxisAlignment: .center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset(Assets.iconsChequeLogo),
                      ),
                      context.szBoxHeight12,
                      Row(
                        mainAxisAlignment: .center,
                        children: [Text(transaction.formattedAmount)],
                      ),
                      context.szBoxHeight12,
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(transaction.getStateIcon),
                          ),
                          context.szBoxWidth12,
                          Text(
                            transaction.typeDescription?.getDescription(
                                  context.locale.languageCode,
                                ) ??
                                "",
                            style: context.semiboldSm,
                          ),
                        ],
                      ),
                      context.szBoxHeight16,
                      PrimaryContainer(
                        bgColor: context.bgTertiary,
                        padding: context.k12Padding,
                        children: [
                          Row(
                            children: [
                              Text("Date", style: context.mediumMutedSm),
                              Spacer(),
                              Text(
                                transaction.formattedDate,
                                style: context.semiboldSm,
                              ),
                            ],
                          ),
                          context.szBoxHeight12,
                          Row(
                            children: [
                              Text(
                                "Wallet owner",
                                style: context.mediumMutedSm,
                              ),
                              context.szBoxWidth16,
                              Expanded(
                                child: Text(
                                  transaction.receiver ?? "",
                                  maxLines: 1,
                                  textAlign: .end,
                                  style: context.semiboldSm,
                                ),
                              ),
                            ],
                          ),
                          context.szBoxHeight12,
                          Row(
                            children: [
                              Text(
                                "Transaction type",
                                style: context.mediumMutedSm,
                              ),
                              context.szBoxWidth16,
                              Expanded(
                                child: Text(
                                  transaction.flowType ?? "",
                                  maxLines: 1,
                                  textAlign: .end,
                                  style: context.semiboldSm,
                                ),
                              ),
                            ],
                          ),
                          context.szBoxHeight12,
                          Row(
                            children: [
                              Text(
                                "Transaction ID",
                                style: context.mediumMutedSm,
                              ),
                              context.szBoxWidth16,
                              Expanded(
                                child: Text(
                                  transaction.extId ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.semiboldSm,
                                ),
                              ),
                              context.szBoxWidth8,
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: transaction.extId ?? "",
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: 'Copied to clipboard',
                                  );
                                },
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(Assets.iconsCopy),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      context.szBoxHeight16,
                      PrimaryContainer(
                        bgColor: context.bgTertiary,
                        padding: context.k12Padding,
                        children: [
                          Row(
                            children: [
                              Text("Comission", style: context.mediumMutedSm),
                              Spacer(),
                              Text("Free", style: context.semiboldSm),
                            ],
                          ),
                          context.szBoxHeight12,
                          Row(
                            children: [
                              Text("Total", style: context.mediumMutedSm),
                              Spacer(),
                              Text(
                                transaction.formattedAmount,
                                style: context.semiboldSm,
                              ),
                            ],
                          ),
                        ],
                      ),
                      context.szBoxHeight16,
                      ChequeStateContainer(
                        transaction: transaction,
                        status: state.transactionStateStatus,
                        onTap: () {
                          if (state.transactionStateStatus != .loading) {
                            HapticFeedback.mediumImpact();
                            _caruselCubit.getTransactionState(widget.extId);
                          }
                        },
                      ),
                      Spacer(),
                      CustomButton(
                        onPressed: () {
                          if (state.transactionStateStatus == .success) {
                            MainRoute().go(context);
                          }
                        },
                        text: "transfer.back_to_home".tr(),
                      ),
                      context.szBoxHeight16,
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  // ignore: unused_element
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
}
