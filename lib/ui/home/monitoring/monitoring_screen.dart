/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart' show TransactionResult;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_sheets.dart' show ModalSheets;

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: false,
      backgroundColor: context.bgMain,
      title: Text("home.monitoring_title".tr(), style: context.semiboldMd),
      actions: [
        Row(
          children: [
            Text("Filter".tr(), style: context.semiboldSm),
            const SizedBox(width: 4),
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(Assets.iconsFilter),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    ),
    body: Builder(
      builder: (context) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: context.bgElevated),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [Text("02.03.2026", style: context.semiboldMd)],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SizedBox(
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Item $index", style: context.textMd),
                                  Text(
                                    "Item description",
                                    style: context.textMutedXs,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("-100", style: context.textMd),
                                  Text(
                                    "11:36",
                                    style: context.textMutedXs,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 10,
        );
      },
    ),
  );
}
