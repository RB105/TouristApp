/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart' show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';
import 'package:touristapp/ui/widgets/asset_svg.dart';
import 'package:touristapp/ui/widgets/custom_button.dart';
import 'package:touristapp/utils/enums/api_status.dart';

import '../../../../../../../generated/assets.dart' show Assets;
import '../../../../../../../utils/extensions/color_extension.dart'
    show ColorExtension;
import '../../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../../../utils/extensions/text_styles_extension.dart'
    show TextStyles;
import '../../../../../../widgets/animated_switcher.dart' show AppAnimatedSwitcher;
import '../../../../../../widgets/primary_container.dart' show PrimaryContainer;

class ChequeStateContainer extends StatefulWidget {
  final MonitoringHistory transaction;
  final ApiStatus status;
  final VoidCallback onTap;

  const ChequeStateContainer({
    super.key,
    required this.transaction,
    required this.status, required this.onTap,
  });

  @override
  State<ChequeStateContainer> createState() => _ChequeStateContainerState();
}

class _ChequeStateContainerState extends State<ChequeStateContainer> {
  Widget _getStateContainer() {
    final tr = widget.transaction;
    if (tr.getTransactionStatus == .success) {
      return PrimaryContainer(
        bgColor: context.bgTertiary,
        padding: context.k12Padding,
        children: [
          Row(
            children: [
              Text("Statement", style: context.mediumMutedSm),
              Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(Assets.iconsDownload),
              ),
              context.szBoxWidth8,
              Text(
                "Download",
                style: context.semiboldSm.copyWith(color: context.info),
              ),
            ],
          ),
        ],
      );
    } else if (tr.getTransactionStatus == .pending) {
      return Column(
        children: [
          PrimaryContainer(
            boxBorder: Border.all(color: context.warning, width: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AssetSvg(Assets.iconsClock),
                context.szBoxWidth12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Transaction",
                        style: context.semiboldMd.copyWith(
                          color: context.warning,
                        ),
                      ),
                      Text(
                        "Your funds are being processed. You can check the status later by tapping the button below.",
                        style: context.textSm.copyWith(color: context.warning),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          context.szBoxHeight16,
          CustomButton(
            onPressed: widget.onTap,
            bgColor: context.bgInfo,
            child: Row(
                mainAxisAlignment: .center,
                children: [
                  AppAnimatedSwitcher(
                    child: widget.status == .loading
                        ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                      ),
                    ) : const SizedBox.shrink(),
                  ),

                  if (widget.status == .loading) context.szBoxWidth8,

                  Text(
                    "transfer.check_status".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: widget.status == .loading
                          // ignore: deprecated_member_use
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black,
                    ),
                  ),

            ]),
          ),
        ],
      );
    } else if (tr.getTransactionStatus == .canceled) {
      return PrimaryContainer(
        boxBorder: Border.all(color: context.error, width: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssetSvg(Assets.iconsError),
            context.szBoxWidth12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transfer Unsuccessful",
                    style: context.semiboldMd.copyWith(color: context.error),
                  ),
                  Text(
                    "Your transfer was not successful. Please review the details and try again, or contact support.",
                    style: context.textSm.copyWith(color: context.error),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return _getStateContainer();
  }
}
