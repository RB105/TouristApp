/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;

import '../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;

class MonitoringShimmerLoading extends StatelessWidget {
  final int groupCount;
  final int itemsPerGroup;
  final bool? shrinkWrap;

  const MonitoringShimmerLoading({
    super.key,
    this.groupCount = 3,
    this.itemsPerGroup = 3,
    this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap ?? false,
      itemCount: groupCount,
      padding: context.k16verticalPadding,
      physics: (shrinkWrap ?? false) ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => Column(
        children: [
          /// Date Header Shimmer
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.bgElevated),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 100,
                    height: 16,
                    decoration: BoxDecoration(
                      color: context.bgMain,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Monitoring Items Shimmer
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemsPerGroup,
            itemBuilder: (context, index) => _MonitoringItemShimmer(),
          ),
        ],
      ),
    );
  }
}

class _MonitoringItemShimmer extends StatelessWidget {
  const _MonitoringItemShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Row(
            children: [
              /// Icon Shimmer
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: context.bgElevated,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              context.szBoxWidth16,

              /// LEFT - Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 14,
                      decoration: BoxDecoration(
                        color: context.bgElevated,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    Container(
                      width: 150,
                      height: 12,
                      decoration: BoxDecoration(
                        color: context.bgElevated,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              context.szBoxWidth16,

              /// RIGHT - Amount and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 80,
                    height: 14,
                    decoration: BoxDecoration(
                      color: context.bgElevated,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: context.bgElevated,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
