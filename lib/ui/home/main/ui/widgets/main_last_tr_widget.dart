/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/model/home_details_result.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class MainLastTrWidget extends StatelessWidget {
  final List<HistoryGroup> historyGroups;

  const MainLastTrWidget({super.key, required this.historyGroups});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: .center,
          children: [
            Text("main.last_transactions".tr(), style: context.semiboldMd),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        context.szBoxHeight12,
        Builder(
          builder: (context) {
            if (historyGroups.isEmpty) {
              return Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(Assets.iconsEmptyBox),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
