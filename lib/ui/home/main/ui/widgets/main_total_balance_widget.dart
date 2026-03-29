/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart' show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class MainTotalBalanceWidget extends StatelessWidget {
  final String balance;
  const MainTotalBalanceWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: context.borderRadius24,
          image: DecorationImage(
            image: AssetImage(Assets.iconsWalletBg),
            fit: .cover,
          ),
        ),
        child: Padding(
          padding: context.k16Padding,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .end,
            children: [
              Text(
                "main.total_balance".tr(),
                style: context.semiboldMutedXs.copyWith(
                  color: context.textDisabled,
                ),
              ),
              Text(
                balance,
                style: context.semiboldDisplaySm.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
