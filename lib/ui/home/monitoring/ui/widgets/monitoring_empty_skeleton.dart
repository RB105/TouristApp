/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/widgets/custom_button.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class MonitoringEmptySkeleton extends StatefulWidget {
  const MonitoringEmptySkeleton({super.key});

  @override
  State<MonitoringEmptySkeleton> createState() =>
      _MonitoringEmptySkeletonState();
}

class _MonitoringEmptySkeletonState extends State<MonitoringEmptySkeleton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Text("Nothing to see here yet.", style: context.semiboldXl),
          Text(
            "Want to transfer? Click to button to start \nyour journey on travel payments",
            textAlign: .center,
            style: context.textMutedMd,
          ),
          context.szBoxHeight8,
          SvgPicture.asset(Assets.iconsMonitoringVector),
          context.szBoxHeight8,
          CustomButton(onPressed: () {
            StatefulNavigationShell.of(context).goBranch(0);
          }, text: "Top up the wallet",width: 180,),
        ],
      ),
    );
  }
}
