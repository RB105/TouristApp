/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/ui/widgets/custom_keyboard.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class QrAmounScreen extends StatefulWidget {
  const QrAmounScreen({super.key});

  @override
  State<QrAmounScreen> createState() => _QrAmounScreenState();
}

class _QrAmounScreenState extends State<QrAmounScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Pay")),
    body: Column(
      children: [
        Text(
          "Enter amount",
          style: context.mediumMd.copyWith(color: context.textSecondary),
        ),
        context.szBoxHeight32,
        Text("\$ 100.00", style: context.boldDisplayXl),
        Row(
          children: [
            Text("Wallet balance:"),
            Text(
              "100.00",
              style: context.semiboldSm.copyWith(color: context.primary),
            ),
          ],
        ),
        Divider(),
        Text("Commission (1.5%)"),
        context.szBoxHeight8,
        Text("0.00 USD", style: context.semiboldSm),
        Divider(),
        CustomKeyboard(onKeyboardTap: (text) {}),
      ],
    ),
  );
}
