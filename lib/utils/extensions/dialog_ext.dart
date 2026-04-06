// ignore_for_file: deprecated_member_use

/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/primary_decoration_ext.dart'
    show PrimaryDecorationExt;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

import 'context_extensions.dart' show ContextExtensions;

extension LoadingDialog on BuildContext {
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

  Future<void> showErrorDialog( {
    required String title,
    bool? isDismissible,
    String? message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) async {
    _updateDialog();
    showDialog(
      context: this,
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
                  Text(title, textAlign: TextAlign.center, style: ctx.mediumMd),
                  szBoxHeight12,
                  if (message != null)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: ctx.mediumMd,
                    ),
                  szBoxHeight24,
                  Center(child: Text(buttonText ?? "", style: textMd)),
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

  void _afterComplete() => _isShowing = false;

  /// 🔥 Always remove previous dialog
  void _updateDialog() {
    if (_isShowing) {
      Navigator.of(this, rootNavigator: true).pop();
      _isShowing = false;
    }

    _isShowing = true;
  }
}

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
