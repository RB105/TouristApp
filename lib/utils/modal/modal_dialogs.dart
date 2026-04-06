// ignore_for_file: deprecated_member_use

/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:ui' show ImageFilter;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/ui/home/main/logic/model/carusel_transfer_service.dart'
    show CaruselTransferService;
import 'package:touristapp/ui/widgets/app_loader.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/primary_decoration_ext.dart'
    show PrimaryDecorationExt;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/router/app_router.dart';

class ModalDialogs {
  static BuildContext? _dialogContext;

  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),

      builder: (ctx) {
        _updateDialogContext(ctx);
        return Center(child: AppLoader());
      },
    ).whenComplete(_afterComplete);
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    bool? isDismissible,
    String? message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: isDismissible ?? true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        _updateDialogContext(ctx);
        return Center(
          child: Padding(
            padding: context.k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: context.k16Padding,
              decoration: context.decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, textAlign: TextAlign.center, style: ctx.mediumMd),
                  context.szBoxHeight12,
                  if (message != null)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: ctx.mediumMd,
                    ),
                  context.szBoxHeight24,
                  Center(child: Text(buttonText ?? "", style: context.textMd)),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_afterComplete);
  }

  static Future<void> showLogOutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        _updateDialogContext(ctx);
        return Center(
          child: Padding(
            padding: context.k20horizontalPadding,
            child: Container(
              width: double.infinity,
              padding: context.k16Padding,
              decoration: context.decoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to log out?",
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  context.szBoxHeight12,
                  Text(
                    "You will need to log in again to access your account.",
                    textAlign: TextAlign.center,
                    style: ctx.mediumMd,
                  ),
                  context.szBoxHeight24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: Text("Cancel", style: context.textMd),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GetStorage().erase();
                          OnBoardingRoute().go(context);
                        },
                        child: Text("Log out", style: context.textMd),
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

  static void showTopUpSheet({
    required BuildContext context,
    List<CaruselTransferService>? services,
    required void Function(CaruselTransferService service) onSelected
  }) {
    Widget item({
      required String title,
      required String subtitle,
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
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "TopUp",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, _, _) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return Stack(
          children: [
            /// 🔥 BLUR + OVERLAY
            GestureDetector(
              onTap: () => Navigator.pop(context),
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

            /// 🔥 SHEET
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
                            /// Header
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
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),

                            context.szBoxHeight16,
                            ListView.builder(
                              itemCount: services?.length ?? 0,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: item(
                                  title:
                                      services?[index].getName(
                                        context.locale.languageCode,
                                      ) ??
                                      "",
                                  subtitle: services?[index].description ?? "",
                                  onTap: () {
                                    if (services?[index].providerId == 9) {
                                      // Navigate to Bank Launcher Screen
                                      context.pop();
                                      onSelected(services![index]);
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
    );
  }

  static void _updateDialogContext(BuildContext context) {
    _dialogContext = context;
  }

  static void _afterComplete() {
    _dialogContext = null;
  }

  static void dismissCurrentDialog<T>({T? result}) {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop(result);
      _dialogContext = null;
    }
  }

  static void showConfirmDialog(
      BuildContext context, {
        required String title,
        required String iconUrl,
        bool? isDismissible,

        String? message,
        String buttonText = 'OK',

        VoidCallback? onConfirm,
      }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible ?? true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (ctx) {
        _updateDialogContext(ctx);
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
                borderRadius: context.borderRadius24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconUrl.contains('png') == true)
                    Image.asset(iconUrl, width: context.width * .3)
                  else
                    SvgPicture.asset(iconUrl),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.boldMd,
                  ),
                  const SizedBox(height: 12),
                  if (message != null)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.textMd,
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.bgMain,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel".tr(),
                            style: context.mediumMd,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      context.szBoxWidth8,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
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
}
