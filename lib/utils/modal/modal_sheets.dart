/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/cupertino.dart';
import 'package:touristapp/ui/home/main/ui/qr_scanner_widget.dart' show QrScannerWidget;

class ModalSheets {
  static BuildContext? _dialogContext;
  static void showQrScanner(BuildContext context) {
    showCupertinoSheet(
      context: context,
      builder: (ctx) {
        _updateDialogContext(ctx);
        return QrScannerWidget();
      },
    ).whenComplete(_afterComplete);
  }

  static void _updateDialogContext(BuildContext context) {
    _dialogContext = context;
  }

  static Future<void> _afterComplete() async {
    _dialogContext = null;
  }

  static void dismissCurrentDialog<T>({T? result}) {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop(result);
      _dialogContext = null;
    }
  }
}
