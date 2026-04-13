// ignore_for_file: deprecated_member_use

/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/widgets/animated_opacity.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class MainTotalBalanceWidget extends StatelessWidget {
  final String balance;
  final bool isLoading;

  const MainTotalBalanceWidget({
    super.key,
    required this.balance,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return BalanceLoadingSkeleton();
    }
    return AppFadeIn(
      duration: Duration(milliseconds: 1500),
      child: Padding(
        padding: context.k16horizontalPadding,
        child: SizedBox(
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
                    style: context.semiboldDisplaySm.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceLoadingSkeleton extends StatelessWidget {
  const BalanceLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.k16horizontalPadding,
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.45),
        highlightColor: Colors.black.withOpacity(0.08),
        period: const Duration(milliseconds: 1500),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: context.borderRadius24,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Padding(
              padding: context.k16Padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Label skeleton
                  Container(
                    width: 120,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  context.szBoxHeight12,

                  /// Balance skeleton
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

