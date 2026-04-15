/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:io' show File, Platform;

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension, BuildContextEasyLocalizationExtension, tr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, XFile, ShareParams;

import '../../../../generated/assets.dart' show Assets;
import '../../../../utils/di/di.dart' show getIt;
import '../../../../utils/extensions/color_extension.dart' show ColorExtension;
import '../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../utils/extensions/text_styles_extension.dart'
    show TextStyles;
import '../../../../utils/router/app_router.dart' show MainRoute;
import '../../../widgets/custom_button.dart' show CustomButton;
import '../../../widgets/primary_container.dart' show PrimaryContainer;
import '../../../widgets/slide_fade_in.dart' show SlideFadeIn;
import '../../main/logic/cubit/carusel/carusel_cubit.dart'
    show CaruselCubit, CaruselState;
import '../../main/ui/screens/top_up/widgets/cheque_loading_skeleton.dart'
    show ChequeLoadingSkeleton;
import '../../main/ui/screens/top_up/widgets/cheque_state_container.dart'
    show ChequeStateContainer;
import '../logic/model/monitoring_result.dart' show MonitoringHistory;

class ChequeScreen extends StatefulWidget {
  final String? extId;
  final MonitoringHistory? item;

  const ChequeScreen({super.key, this.extId, this.item});

  static const String routeName = '/cheque-screen';

  @override
  State<ChequeScreen> createState() => _ChequeScreenState();
}

class _ChequeScreenState extends State<ChequeScreen> {
  final _screenshotController = ScreenshotController();

  final _caruselCubit = getIt<CaruselCubit>();

  String get _getExtId {
    if (widget.extId?.isNotEmpty ?? false) {
      return widget.extId!;
    }
    return widget.item?.extId ?? "";
  }

  @override
  void initState() {
    // state check in init
    if (widget.extId?.isNotEmpty ?? false) {
      _caruselCubit.getTransactionState(widget.extId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _caruselCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: widget.item != null
              ? IconButton(onPressed: () => context.pop(), icon: Icon(Icons.close))
              : null,
          centerTitle: Platform.isIOS,
          title: Text("transfer.tr_details".tr()),
        ),
        body: BlocBuilder<CaruselCubit, CaruselState>(
          builder: (context, state) {
            if (state.transactionStateStatus == .loading &&
                state.transactionState == null && widget.item == null) {
              return const ChequeLoadingSkeleton();
            } else if (state.transactionStateStatus == .error ) {
              final transaction =
                  state.transactionState ?? widget.item ?? MonitoringHistory();
              return Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: InkWell(
                    onTap: () => _caruselCubit.getTransactionState(widget.extId ?? transaction.extId ?? ""),
                    borderRadius: BorderRadius.circular(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.transactionStateError,
                          style: context.semiboldLg.copyWith(color: context.error),
                          textAlign: TextAlign.center,
                        ),
                        context.szBoxHeight8,
                        Text(
                          "transfer.cheque.retry".tr(),
                          style: context.mediumMd  //b16W500H20Manrope,
                        ),
                        context.szBoxHeight8,
                        Icon(Icons.refresh_outlined),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.transactionStateStatus == .success ||
                state.transactionState != null ||
                widget.item != null) {
              final transaction =
                  state.transactionState ?? widget.item ?? MonitoringHistory();
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
                            _caruselCubit.getTransactionState(_getExtId);
                          }
                        },
                      ),
                      Spacer(),
                      CustomButton(
                        onPressed: () {
                          if (widget.item != null) {
                            context.pop();
                            return;
                          }
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
