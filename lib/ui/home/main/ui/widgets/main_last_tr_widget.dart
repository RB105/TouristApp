/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';
import 'package:touristapp/ui/home/monitoring/ui/widgets/monitoring_shimmer_loading.dart';
import 'package:touristapp/ui/widgets/animation_list.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

import '../../../../../utils/router/app_router.dart' show SbpChequesScreenRoute;

class MainLastTrWidget extends StatelessWidget {
  final List<MonitoringHistory> history;
  final bool isLoading;

  const MainLastTrWidget({
    super.key,
    required this.history,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MonitoringShimmerLoading(shrinkWrap: true, itemsPerGroup: 1);
    }
    return Column(
      children: [
        Padding(
          padding: context.k16horizontalPadding,
          child: InkWell(
            onTap: () => StatefulNavigationShell.of(context).goBranch(2),
            child: Row(
              crossAxisAlignment: .center,
              children: [
                Text("main.last_transactions".tr(), style: context.semiboldMd),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        context.szBoxHeight12,
        Visibility(
          replacement: Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(Assets.iconsEmptyBox),
            ),
          ),
          visible: history.isNotEmpty,
          child: AnimationList(
            duration: 1200,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(history.length, (i) => SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.bgMain),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    SbpChequesScreenRoute(
                    monitoringItem: history[i],
                  ).push(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(Assets.iconsTrOutSuccess),
                      ),
                      context.szBoxWidth16,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            history[i].receiver ?? "",
                            style: context.textMd,
                            overflow: .ellipsis,
                          ),
                          Text(
                            history[i].description ?? "",
                            style: context.textMutedXs,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            history[i].formattedAmount,
                            style: context.textMd,
                          ),
                          Text(
                            history[i].formattedDate,
                            style: context.textMutedXs,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),),
        ),
      ],
    );
  }
}
