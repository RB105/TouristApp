/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/cupertino.dart';
import 'package:touristapp/ui/home/main/logic/model/home_details_result.dart';
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart';
import 'package:touristapp/ui/home/main/ui/screens/qr/qr_cheque_screen.dart'
    show QrChequeScreen;
import 'package:touristapp/ui/home/main/ui/screens/qr/qr_scan_screen.dart';

import '../../ui/home/main/logic/model/qr_check_result.dart' show QrCheckResult;

class ModalSheets {
  static BuildContext? _dialogContext;

  static void showQrScanner(BuildContext context,
      {required void Function(QrCheckResult qrCheckResult) onResult, required Wallet wallet}) {
    showCupertinoSheet(
      context: context,
      builder: (ctx) {
        _updateDialogContext(ctx);
        return QrScanScreen(onResult: onResult, wallet: wallet);
      },
    ).whenComplete(_afterComplete);
  }

  static void showQrCheque(BuildContext context, {
    required TransactionResult transaction,
  }) {
    showCupertinoSheet(
      context: context,
      builder: (ctx) {
        _updateDialogContext(ctx);
        return QrChequeScreen(transaction: transaction);
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
