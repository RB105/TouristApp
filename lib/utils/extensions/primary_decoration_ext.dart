/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart' show BoxDecoration, BoxShadow, BuildContext, Offset;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';

extension PrimaryDecorationExt on BuildContext {
  BoxDecoration get decoration => BoxDecoration(
    color: bgElevated,
    borderRadius: borderRadius24,
    boxShadow: [
      BoxShadow(
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: .1,
        color: shadow,
      ),
    ],
  );
}
