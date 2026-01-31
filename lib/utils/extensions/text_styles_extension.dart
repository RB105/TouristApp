/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

extension TextStyles on BuildContext {
  // Regular (400)
  TextStyle get textXs => textStyle(12, FontWeight.w400);
  TextStyle get textSm => textStyle(14, FontWeight.w400);
  TextStyle get textMd => textStyle(16, FontWeight.w400);
  TextStyle get textLg => textStyle(18, FontWeight.w400);
  TextStyle get textXl => textStyle(20, FontWeight.w400);

  // ✅ Muted Regular (400)
  TextStyle get textMutedXs => textStyle(12, FontWeight.w400, muted: true);
  TextStyle get textMutedSm => textStyle(14, FontWeight.w400, muted: true);
  TextStyle get textMutedMd => textStyle(16, FontWeight.w400, muted: true);
  TextStyle get textMutedLg => textStyle(18, FontWeight.w400, muted: true);
  TextStyle get textMutedXl => textStyle(20, FontWeight.w400, muted: true);

  // Medium (500)
  TextStyle get mediumXs => textStyle(12, FontWeight.w500);
  TextStyle get mediumSm => textStyle(14, FontWeight.w500);
  TextStyle get mediumMd => textStyle(16, FontWeight.w500);
  TextStyle get mediumLg => textStyle(18, FontWeight.w500);
  TextStyle get mediumXl => textStyle(20, FontWeight.w500);

  // ✅ Muted Medium (500)
  TextStyle get mediumMutedXs => textStyle(12, FontWeight.w500, muted: true);
  TextStyle get mediumMutedSm => textStyle(14, FontWeight.w500, muted: true);
  TextStyle get mediumMutedMd => textStyle(16, FontWeight.w500, muted: true);
  TextStyle get mediumMutedLg => textStyle(18, FontWeight.w500, muted: true);
  TextStyle get mediumMutedXl => textStyle(20, FontWeight.w500, muted: true);

  // Semibold (600)
  TextStyle get semiboldXs => textStyle(12, FontWeight.w600);
  TextStyle get semiboldSm => textStyle(14, FontWeight.w600);
  TextStyle get semiboldMd => textStyle(16, FontWeight.w600);
  TextStyle get semiboldLg => textStyle(18, FontWeight.w600);
  TextStyle get semiboldXl => textStyle(20, FontWeight.w600);

  TextStyle get semiboldDisplayXs => textStyle(24, FontWeight.w600);
  TextStyle get semiboldDisplaySm => textStyle(28, FontWeight.w600);
  TextStyle get semiboldDisplayMd => textStyle(36, FontWeight.w600);
  TextStyle get semiboldDisplayLg => textStyle(48, FontWeight.w600);
  TextStyle get semiboldDisplayXl => textStyle(64, FontWeight.w600);
  TextStyle get semiboldDisplay2Xl => textStyle(72, FontWeight.w600);

  // ✅ Muted Semibold (600)
  TextStyle get semiboldMutedXs => textStyle(12, FontWeight.w600, muted: true);
  TextStyle get semiboldMutedSm => textStyle(14, FontWeight.w600, muted: true);
  TextStyle get semiboldMutedMd => textStyle(16, FontWeight.w600, muted: true);
  TextStyle get semiboldMutedLg => textStyle(18, FontWeight.w600, muted: true);
  TextStyle get semiboldMutedXl => textStyle(20, FontWeight.w600, muted: true);

  // Bold (700)
  TextStyle get boldXs => textStyle(12, FontWeight.w700);
  TextStyle get boldSm => textStyle(14, FontWeight.w700);
  TextStyle get boldMd => textStyle(16, FontWeight.w700);
  TextStyle get boldLg => textStyle(18, FontWeight.w700);
  TextStyle get boldXl => textStyle(20, FontWeight.w700);

  TextStyle get boldDisplayXs => textStyle(24, FontWeight.w700);
  TextStyle get boldDisplaySm => textStyle(28, FontWeight.w700);
  TextStyle get boldDisplayMd => textStyle(36, FontWeight.w700);
  TextStyle get boldDisplayLg => textStyle(48, FontWeight.w700);
  TextStyle get boldDisplayXl => textStyle(64, FontWeight.w700);
  TextStyle get boldDisplay2Xl => textStyle(72, FontWeight.w700);

  // ✅ Muted Bold (700)
  TextStyle get boldMutedXs => textStyle(12, FontWeight.w700, muted: true);
  TextStyle get boldMutedSm => textStyle(14, FontWeight.w700, muted: true);
  TextStyle get boldMutedMd => textStyle(16, FontWeight.w700, muted: true);
  TextStyle get boldMutedLg => textStyle(18, FontWeight.w700, muted: true);
  TextStyle get boldMutedXl => textStyle(20, FontWeight.w700, muted: true);

  TextStyle textStyle(
      double fontSize,
      FontWeight fontWeight, {
        bool muted = false,
        Color? color,
      }) {
    final theme = Theme.of(this);
    final isLight = theme.brightness == Brightness.light;

    // Default text colors
    final baseColor = color ?? (isLight ? Colors.black : Colors.white);

    // Muted color (simple + readable)
    final mutedColor = isLight ? Colors.black54 : Colors.white70;

    return TextStyle(

      fontSize: fontSize,
      fontWeight: fontWeight,
      color: muted ? mutedColor : baseColor,
    );
  }
}

