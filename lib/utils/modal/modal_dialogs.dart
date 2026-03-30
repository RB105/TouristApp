// ignore_for_file: deprecated_member_use

/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/ui/widgets/app_loader.dart';
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

  static Future<void> showLogOutDialog(
    BuildContext context) async {
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
                  Text("Do you want to log out?", textAlign: TextAlign.center, style: ctx.mediumMd),
                  context.szBoxHeight12,
                  Text("You will need to log in again to access your account.", textAlign: TextAlign.center, style: ctx.mediumMd),
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

  static void _updateDialogContext(BuildContext context) {
    _dialogContext = context;
  }

  static void _afterComplete()  {
    _dialogContext = null;
  }

  static void dismissCurrentDialog<T>({T? result}) {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop(result);
      _dialogContext = null;
    }
  }
}
