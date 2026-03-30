/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart'
    show TransactionResult;
import 'package:touristapp/ui/widgets/custom_button.dart';
import 'package:touristapp/ui/widgets/primary_container.dart'
    show PrimaryContainer;
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class QrChequeScreen extends StatefulWidget {
  final TransactionResult transaction;

  const QrChequeScreen({super.key, required this.transaction});

  @override
  State<QrChequeScreen> createState() => _QrChequeScreenState();
}

class _QrChequeScreenState extends State<QrChequeScreen> {
  String get _getStateIcon {
    if (1 == 1) {
      return Assets.iconsCheck;
    }
    return Assets.iconsProcessing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        title: Text("Operation details"),
      ),
      body: Padding(
        padding: context.k16Padding,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(Assets.iconsChequeLogo),
            ),
            context.szBoxHeight12,
            Row(
              mainAxisAlignment: .center,
              children: [Text(widget.transaction.getBalance())],
            ),
            context.szBoxHeight12,
            Row(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(_getStateIcon),
                ),
                context.szBoxWidth12,
                Text(
                  widget.transaction.description ?? "",
                  style: context.semiboldSm,
                ),
              ],
            ),
            context.szBoxHeight16,
            PrimaryContainer(
              bgColor: context.bgTertiary,
              padding: context.k12Padding,
              children: [
                Row(
                  children: [
                    Text("Date", style: context.mediumMutedSm),
                    Spacer(),
                    Text(widget.transaction.formattedCreatedAt),
                  ],
                ),
                Row(
                  children: [
                    Text("Wallet owner", style: context.mediumMutedSm),
                    Spacer(),
                    Text(widget.transaction.receiver ?? ""),
                  ],
                ),
                Row(
                  children: [
                    Text("Transaction ID", style: context.mediumMutedSm),
                    context.szBoxWidth16,
                    Expanded(
                      child: Text(
                        widget.transaction.extId ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    context.szBoxWidth8,
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.transaction.extId ?? ""),
                        );
                        Fluttertoast.showToast(msg: 'Copied to clipboard');
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(Assets.iconsCopy),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            context.szBoxHeight16,
            PrimaryContainer(
              bgColor: context.bgTertiary,
              padding: context.k12Padding,
              children: [
                Row(
                  children: [
                    Text("Amount", style: context.mediumMutedSm),
                    Spacer(),
                    Text(widget.transaction.getBalance()),
                  ],
                ),
                Row(
                  children: [
                    Text("Comission", style: context.mediumMutedSm),
                    Spacer(),
                    Text("Free"),
                  ],
                ),
              ],
            ),
            context.szBoxHeight16,
            PrimaryContainer(
              bgColor: context.bgTertiary,
              padding: context.k12Padding,
              children: [
                Row(
                  children: [
                    Text("Comission", style: context.mediumMutedSm),
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
            ),
            Spacer(),
            CustomButton(
              onPressed: () {
                context.pop();
              },
              text: "Go Back",
            ),
            context.szBoxHeight16,
          ],
        ),
      ),
    );
  }
}
