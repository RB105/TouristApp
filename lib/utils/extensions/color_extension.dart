/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';

import '../const/const_colors.dart' show ConstColors;

extension ColorExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // =========================
  // Backgrounds
  // =========================

  Color get bgMain =>
      isDarkMode ? ConstColors.bgDefaultDark : ConstColors.bgDefaultLight;

  Color get bgSecondary =>
      isDarkMode ? ConstColors.bgSubtleDark : ConstColors.bgSubtleLight;

  Color get bgElevated =>
      isDarkMode ? ConstColors.bgElevatedDark : ConstColors.bgElevatedLight;

  Color get bgTertiary =>
      isDarkMode ? ConstColors.bgTertiaryDark : ConstColors.bgTertiaryLight;

  Color get bgMuted =>
      isDarkMode
          ? ConstColors.bgMutedNeutralDark
          : ConstColors.bgMutedNeutralLight;

  // ---- State backgrounds
  Color get bgSuccess =>
      isDarkMode ? ConstColors.successBgDark : ConstColors.successBgLight;

  Color get bgAlert =>
      isDarkMode ? ConstColors.warningBgDark : ConstColors.warningBgLight;

  Color get bgError =>
      isDarkMode ? ConstColors.errorBgDark : ConstColors.errorBgLight;

  Color get bgInfo =>
      isDarkMode ? ConstColors.infoBgDark : ConstColors.infoBgLight;

  // =========================
  // Text
  // =========================

  Color get textMain =>
      isDarkMode ? ConstColors.textDefaultDark : ConstColors.textDefaultLight;

  Color get textSecondary =>
      isDarkMode ? ConstColors.textMutedDark : ConstColors.textMutedLight;

  Color get textDisabled =>
      isDarkMode ? ConstColors.textDisabledDark : ConstColors.textDisabledLight;

  Color get textLink =>
      isDarkMode ? ConstColors.textLinkDark : ConstColors.textLinkLight;

  Color get textLinkHover =>
      isDarkMode
          ? ConstColors.textLinkHoverDark
          : ConstColors.textLinkHoverLight;

  // =========================
  // Actions / Primary
  // =========================

  Color get primary =>
      isDarkMode
          ? ConstColors.actionPrimaryDark
          : ConstColors.actionPrimaryLight;

  Color get primaryHover =>
      isDarkMode
          ? ConstColors.actionPrimaryHoverDark
          : ConstColors.actionPrimaryHoverLight;

  Color get primaryPressed =>
      isDarkMode
          ? ConstColors.actionPrimaryPressedDark
          : ConstColors.actionPrimaryPressedLight;

  Color get primaryDisabled =>
      isDarkMode
          ? ConstColors.actionPrimaryDisabledDark
          : ConstColors.actionPrimaryDisabledLight;

  // =========================
  // Icons
  // =========================

  Color get iconMain =>
      isDarkMode ? ConstColors.iconPrimaryDark : ConstColors.iconPrimaryLight;

  Color get iconSecondary =>
      isDarkMode
          ? ConstColors.iconSecondaryDark
          : ConstColors.iconSecondaryLight;

  Color get iconDisabled =>
      isDarkMode
          ? ConstColors.iconDisabledDark
          : ConstColors.iconDisabledLight;

  Color get iconBrand => primary;

  // =========================
  // Stroke / Borders
  // =========================

  Color get strokeMain =>
      isDarkMode
          ? ConstColors.borderDefaultDark
          : ConstColors.borderDefaultLight;

  Color get strokeSecondary =>
      isDarkMode
          ? ConstColors.borderSecondaryDark
          : ConstColors.borderSecondaryLight;

  Color get strokeTertiary =>
      isDarkMode
          ? ConstColors.borderTertiaryDark
          : ConstColors.borderTertiaryLight;

  Color get strokeBrand => primary;

  // =========================
  // Helper colors (semantic)
  // =========================

  Color get success =>
      isDarkMode ? ConstColors.successTextDark : ConstColors.successText;

  Color get warning =>
      isDarkMode ? ConstColors.warningTextDark : ConstColors.warningText;

  Color get error =>
      isDarkMode ? ConstColors.errorTextDark : ConstColors.errorText;

  Color get info =>
      isDarkMode ? ConstColors.infoTextDark : ConstColors.infoText;

  // =========================
  // Shadows / Overlay
  // =========================

  Color get overlay =>
      isDarkMode ? ConstColors.overlay60 : ConstColors.overlay25;

  Color get shadow =>
      isDarkMode ? ConstColors.shadowDark : ConstColors.shadowLight;

  List<BoxShadow> get boxShadow => [
    BoxShadow(
      color: shadow,
      offset: const Offset(0, 1),
      blurRadius: 4,
    ),
  ];
}
