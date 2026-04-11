/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touristapp/utils/extensions/color_extension.dart' show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart' show ContextExtensions;
import '../../../../../../widgets/primary_container.dart' show PrimaryContainer;

class ChequeLoadingSkeleton extends StatelessWidget {
  const ChequeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: context.k16Padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Logo Shimmer (40x40)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.bgElevated,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            context.szBoxHeight12,

            /// Amount Shimmer
            Container(
              width: 150,
              height: 24,
              decoration: BoxDecoration(
                color: context.bgElevated,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            context.szBoxHeight12,

            /// Status Row Shimmer (icon + text)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.bgElevated,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                context.szBoxWidth12,
                Container(
                  width: 120,
                  height: 14,
                  decoration: BoxDecoration(
                    color: context.bgElevated,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            context.szBoxHeight16,

            /// First Container (Date, Wallet owner, Transaction ID)
            _ContainerShimmer(
              bgColor: context.bgTertiary,
              itemCount: 3,
            ),
            context.szBoxHeight16,

            /// Second Container (Amount, Commission)
            _ContainerShimmer(
              bgColor: context.bgTertiary,
              itemCount: 2,
            ),
            context.szBoxHeight16,

            /// Third Container (Download)
            _ContainerShimmer(
              bgColor: context.bgTertiary,
              itemCount: 1,
              hasIcon: true,
            ),
            const Spacer(),

            /// Button Shimmer
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: context.bgElevated,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            context.szBoxHeight16,
          ],
        ),
      ),
    );
  }
}

class _ContainerShimmer extends StatelessWidget {
  final Color bgColor;
  final int itemCount;
  final bool hasIcon;

  const _ContainerShimmer({
    required this.bgColor,
    required this.itemCount,
    this.hasIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      bgColor: bgColor,
      padding: context.k12Padding,
      children: List.generate(
        itemCount,
            (index) => Padding(
          padding: EdgeInsets.only(bottom: index < itemCount - 1 ? 12 : 0),
          child: Row(
            children: [
              /// Label Shimmer
              Container(
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: context.bgElevated,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              if (hasIcon && index == 0) ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.bgElevated,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                context.szBoxWidth8,
              ],
              /// Value Shimmer
              Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                  color: context.bgElevated,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
