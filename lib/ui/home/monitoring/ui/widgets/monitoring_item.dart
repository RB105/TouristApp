/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:touristapp/utils/modal/modal_sheets.dart';

import '../../../../../generated/assets.dart' show Assets;
import '../../../../../utils/extensions/color_extension.dart'
    show ColorExtension;
import '../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../utils/extensions/text_styles_extension.dart'
    show TextStyles;
import '../../../main/logic/model/transaction_result.dart'
    show TransactionResult;
import '../../logic/model/monitoring_result.dart' show MonitoringHistory;

class MonitoringItem extends StatelessWidget {
  final MonitoringHistory item;

  const MonitoringItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.bgMain),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: InkWell(
            onTap: () => ModalSheets.showQrCheque(
              context,
              transaction: TransactionResult.sample(),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(Assets.iconsTrOutSuccess),
                ),
                context.szBoxWidth16,

                /// LEFT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.receiver ?? "",
                        style: context.textMd,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(item.description ?? "", style: context.textMutedXs),
                    ],
                  ),
                ),

                /// RIGHT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item.getAmount, style: context.textMd),
                    Text(item.getCreateDateTime, style: context.textMutedXs),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
