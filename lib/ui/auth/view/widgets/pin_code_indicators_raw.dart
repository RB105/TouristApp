/* September 2025 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

import '../../../../generated/assets.dart' show Assets;
import '../../../widgets/asset_svg.dart' show AssetSvg;
import '../../../widgets/shake_widget_anim.dart'
    show ShakeWidgetState, ShakeWidget;

class PinCodeIndicatorsRaw extends StatelessWidget {
  final String input;
  final GlobalKey<ShakeWidgetState> shakeKey;

  const PinCodeIndicatorsRaw({
    super.key,
    required this.shakeKey,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      key: shakeKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          5,
          (i) => Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: AssetSvg(
              i < input.length
                  ? Assets.iconsPinDotActive
                  : Assets.iconsPinDotDisabled,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
