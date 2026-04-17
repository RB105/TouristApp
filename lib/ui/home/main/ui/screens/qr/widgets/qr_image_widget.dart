/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:touristapp/ui/widgets/primary_container.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

import '../../../../logic/model/home_details_result.dart';

class QrImageWidget extends StatelessWidget {
  final Wallet wallet;

  const QrImageWidget({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          PrimaryContainer(
            radius: 20,
            children: [
              Text(wallet.getName, style: context.mediumMutedMd),
              context.szBoxHeight4,
              Text(wallet.phone??"", style: context.mediumMutedSm),
            ],
          ),
          context.szBoxHeight4,
          Expanded(
            child: PrimaryContainer(
              radius: 20,
              child: Center(
                child: QrImageView(
                  data: wallet.walletId ?? "",
                  version: QrVersions.auto,
                  size: 180,
                  padding: EdgeInsets.zero,
                  gapless: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
