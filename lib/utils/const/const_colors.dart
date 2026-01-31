/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart' show Color;

class ConstColors {
  ConstColors._();

  // -------------------------
  // Backgrounds
  // -------------------------
  static const bgDefaultLight = Color(0xFFF1F2F3);
  static const bgDefaultDark  = Color(0xFF020202);

  static const bgSubtleLight  = Color(0xFFECF0F6);
  static const bgSubtleDark   = Color(0xFF0B1220);

  static const bgElevatedLight = Color(0xFFFFFFFF);
  static const bgElevatedDark  = Color(0xFF111827);

  static const bgTertiaryLight = Color(0xFFEFF3F8);
  static const bgTertiaryDark  = Color(0xFF0F172A);

  static const bgMutedNeutralLight = Color(0xFFDCDEE2);
  static const bgMutedNeutralDark  = Color(0xFF2D3548);

  // -------------------------
  // Text
  // -------------------------
  static const textDefaultLight = Color(0xFF020202);
  static const textDefaultDark  = Color(0xFFF8FAFC);

  static const textMutedLight = Color(0xFF717F95);
  static const textMutedDark  = Color(0xFFCBD5E1);

  static const textDisabledLight = Color(0xFF9FA8B5);
  static const textDisabledDark  = Color(0xFF64748B);

  static const textLinkLight = Color(0xFF018CFE);
  static const textLinkDark  = Color(0xFF4DA3FF);

  static const textLinkHoverLight = Color(0xFF0176D5);
  static const textLinkHoverDark  = Color(0xFF338FFF);

  // -------------------------
  // Action / Brand
  // -------------------------
  static const actionPrimaryLight = Color(0xFF401CE2);
  static const actionPrimaryDark  = Color(0xFF6E4DFF);

  static const actionPrimaryHoverLight = Color(0xFF1C0099);
  static const actionPrimaryHoverDark  = Color(0xFF5833FF);

  static const actionPrimaryPressedLight = Color(0xFF130066);
  static const actionPrimaryPressedDark  = Color(0xFF421FE0);

  static const actionPrimaryDisabledLight = Color(0xFFA49CC9);
  static const actionPrimaryDisabledDark  = Color(0xFF483A87);

  // -------------------------
  // Borders / Stroke
  // -------------------------
  static const borderDefaultLight = Color(0xFFE2E8F0);
  static const borderDefaultDark  = Color(0xFF231E3B);

  static const borderSecondaryLight = Color(0xFFCBD5E1);
  static const borderSecondaryDark  = Color(0xFF393355);

  static const borderTertiaryLight = Color(0xFFE5E7EB);
  static const borderTertiaryDark  = Color(0xFF231F37);

  static const borderBrandLight = actionPrimaryLight;
  static const borderBrandDark  = actionPrimaryDark;

  // -------------------------
  // Icons
  // -------------------------
  static const iconPrimaryLight = Color(0xFF0F172A);
  static const iconPrimaryDark  = Color(0xFFE5E7EB);

  static const iconSecondaryLight = Color(0xFF989FA9);
  static const iconSecondaryDark  = Color(0xFF94A3B8);

  static const iconDisabledLight = Color(0xFF9FA8B5);
  static const iconDisabledDark  = Color(0xFF64748B);

  static const iconBrandLight = actionPrimaryLight;
  static const iconBrandDark  = actionPrimaryDark;

  // -------------------------
  // State Backgrounds
  // -------------------------
  static const successBgLight = Color(0xFFE8F7EF);
  static const successBgDark  = Color(0xFF0F3D2E);

  static const warningBgLight = Color(0xFFFFF4E5);
  static const warningBgDark  = Color(0xFF3A2A10);

  static const errorBgLight = Color(0xFFFDECEC);
  static const errorBgDark  = Color(0xFF3D1D28);

  static const infoBgLight = Color(0xFFEAF3FF);
  static const infoBgDark  = Color(0xFF0D224D);

  // -------------------------
  // State Text / Icons
  // -------------------------
  static const successText = Color(0xFF22C55E);
  static const warningText = Color(0xFFF59E0B);
  static const errorText   = Color(0xFFEF4444);
  static const infoText    = Color(0xFF018CFE);

  static const successTextDark = Color(0xFF22C55E);
  static const warningTextDark = Color(0xFFFBBF24);
  static const errorTextDark   = Color(0xFFF87171);
  static const infoTextDark    = Color(0xFF4DA3FF);

  // -------------------------
  // System
  // -------------------------
  static const overlay25 = Color.fromRGBO(0, 0, 0, 0.25);
  static const overlay60 = Color.fromRGBO(0, 0, 0, 0.60);

  static const shadowLight = Color(0xFFE5E7EB);
  static const shadowDark  = Color.fromRGBO(0, 0, 0, 0.25);
}
