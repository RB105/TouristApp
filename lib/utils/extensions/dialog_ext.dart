// ignore_for_file: deprecated_member_use

/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:ui' show ImageFilter;

import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension, StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:go_router/go_router.dart' show GoRouterHelper;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/primary_decoration_ext.dart'
    show PrimaryDecorationExt;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

import '../../generated/assets.dart' show Assets;
import '../../ui/home/main/logic/model/carusel_transfer_service.dart'
    show CaruselTransferService;
import '../router/app_router.dart' show OnBoardingRoute;
import 'context_extensions.dart' show ContextExtensions;

part 'sheets.ext.dart';

extension DialogExt on BuildContext {
  static bool _isShowing = false;

  Future<void> showLoading({bool barrierDismissible = true}) async {
    _updateDialog();

    showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.1),
      useRootNavigator: true,
      builder: (_) {
        return const _LoadingDialog();
      },
    ).whenComplete(_afterComplete);
  }

  Future<void> showErrorDialog({
    required String title,
    bool? isDismissible,
    String? message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) async {
    _updateDialog();
    await showDialog(
      context: this,
      useRootNavigator: true,
      barrierDismissible: isDismissible ?? true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        return Center(
          child: Padding(
            padding: k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: k16Padding,
              decoration: decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, textAlign: .center, style: ctx.mediumMd),
                  szBoxHeight12,
                  Visibility(
                    visible: message?.isNotEmpty ?? false,
                    child: Text(
                      message ?? "",
                      textAlign: TextAlign.center,
                      style: ctx.mediumMd,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }

  void showTopUpSheet({
    List<CaruselTransferService>? services,
    required void Function(CaruselTransferService service) onSelected,
  }) {
    _updateDialog();
    showGeneralDialog(
      context: this,
      barrierDismissible: true,
      barrierLabel: "TopUp",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, _, _) => const SizedBox(),
      transitionBuilder: (sheetContext, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return Stack(
          children: [
            GestureDetector(
              onTap: () => sheetContext.pop(),
              child: FadeTransition(
                opacity: curve,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 12 * animation.value,
                    sigmaY: 12 * animation.value,
                  ),
                  child: Container(color: const Color(0xB2401CE2)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curve),
                child: FadeTransition(
                  opacity: curve,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Choose top-up method",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => sheetContext.pop(),
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            szBoxHeight16,
                            ListView.builder(
                              itemCount: services?.length ?? 0,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (itemContext, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _item(
                                  context: itemContext,
                                  title: services?[index].getName(
                                    itemContext.locale.languageCode,
                                  ) ??
                                      "",
                                  subtitle: services?[index].description ?? "",
                                  onTap: () {
                                    if (services?[index].providerId == 9) {
                                      onSelected(services![index]);
                                      sheetContext.pop();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(_afterComplete);
  }

  void showConfirmDialog({
    required String title,
    required String iconUrl,
    bool? isDismissible,

    String? message,
    String buttonText = 'OK',

    VoidCallback? onConfirm,
  }) {
    _updateDialog();
    showDialog(
      context: this,
      barrierDismissible: isDismissible ?? true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              // responsive width
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconUrl.contains('png') == true)
                    Image.asset(iconUrl, width: width * .3)
                  else
                    SvgPicture.asset(iconUrl),
                  const SizedBox(height: 24),
                  Text(title, textAlign: TextAlign.center, style: boldMd),
                  const SizedBox(height: 12),
                  if (message != null)
                    Text(message, textAlign: TextAlign.center, style: textMd),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgMain,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            pop();
                          },
                          child: Text(
                            "Cancel".tr(),
                            style: mediumMd,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      szBoxWidth8,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            pop();
                            if (onConfirm != null) onConfirm();
                          },
                          child: Text(
                            buttonText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }

  /// Add this method to the DialogExt extension in dialog_ext.dart
  /// Place it after the showLogOutDialog() method (around line 341)

  Future<void> showForgotPinDialog({
    VoidCallback? onResetPin,
  }) async {
    _updateDialog();
    showDialog(
      context: this,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        return Center(
          child: Padding(
            padding: k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: k16Padding,
              decoration: decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Icon/Header
                  SvgPicture.asset(
                    Assets.iconsLock,
                    width: 48,
                    height: 48,
                    colorFilter: ColorFilter.mode(
                      primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  szBoxHeight16,
                  Text(
                    "auth.forgot_pin_title".tr(),
                    textAlign: TextAlign.center,
                    style: ctx.boldDisplayXs,
                  ),
                  szBoxHeight12,
                  Text(
                    "auth.forgot_pin_description".tr(),
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd.copyWith(
                      color: textSecondary,
                    ),
                  ),
                  szBoxHeight24,
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgMain,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => pop(),
                          child: Text(
                            "auth.cancel".tr(),
                            style: mediumMd,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      szBoxWidth8,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            pop();
                            GetStorage().erase();
                            OnBoardingRoute().go(this);
                            if (onResetPin != null) onResetPin();
                          },
                          child: Text(
                            "auth.reset_pin".tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }


  Future<void> showLogOutDialog() async {
    _updateDialog();
    showDialog(
      context: this,
      barrierDismissible: true,
      builder: (ctx) {
        return Center(
          child: Padding(
            padding: k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: k16Padding,
              decoration: decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to log out?",
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  szBoxHeight12,
                  Text(
                    "You will need to log in again to access your account.",
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  szBoxHeight24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => pop(),
                        child: Text("Cancel", style: textMd),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GetStorage().erase();
                          OnBoardingRoute().go(this);
                        },
                        child: Text("Log out", style: textMd),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }


  Future<bool?> showForgotPasswordDialog({bool? dismissible}) {
    _updateDialog();
    return showDialog<bool?>(
      context: this,
      barrierDismissible: dismissible ?? true,
      builder: (ctx) {
        return Center(
          child: Padding(
            padding: k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: k16Padding,
              decoration: decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "auth.forgot_password_title".tr(),
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  szBoxHeight12,
                  Text(
                    "auth.forgot_password_desc".tr(),
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  szBoxHeight24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => pop(),
                        child: Text("auth.cancel".tr(), style: textMd),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GetStorage().erase();
                          pop(true);
                        },
                        child: Text("auth.forgot_password_confirm".tr(), style: textMd),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }

  void hideDialog() {
    if (_isShowing) {
      Navigator.of(this, rootNavigator: true).pop();
      _isShowing = false;
    }
  }

  void _updateDialog() => _OverlayState.beforeShow(this);
  void _afterComplete() => _OverlayState.afterClose();
}

Widget _item({
  required String title,
  required String subtitle,
  required BuildContext context,
  VoidCallback? onTap,
}) => InkWell(
  onTap: onTap,
  child: Container(
    padding: context.k16Padding,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        const Icon(Icons.payment),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              context.szBoxHeight4,
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    ),
  ),
);

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.bgInfo,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
    );
  }
}
