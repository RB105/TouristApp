/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart' show NumberFormat;
import 'package:get_storage/get_storage.dart';

extension StringExt on String {

  /// reads data from given **String key**
  dynamic get read {
    return GetStorage().read(this);
  }

  String formatAsMoney({int? decimalDigits}) {
    final cleaned = replaceAll(' ', '').replaceAll(',', '');
    final number = double.tryParse(cleaned);
    if (number == null) return this;

    late NumberFormat formatter;

    if (decimalDigits != null) {
      // Always use fixed decimalDigits
      formatter = NumberFormat.currency(
        locale: 'en_US',
        symbol: '',
        decimalDigits: decimalDigits,
      );
    } else {
      // Format depending on decimal part
      final isWholeNumber = number == number.toInt();
      final hasNonZeroDecimals =
          number.toString().contains('.') &&
          number.toString().split('.')[1].replaceAll('0', '').isNotEmpty;

      formatter = NumberFormat.currency(
        locale: 'en_US',
        symbol: '',
        decimalDigits: isWholeNumber || !hasNonZeroDecimals ? 0 : null,
      );
    }

    return formatter.format(number).replaceAll(',', ' ');
  }
}
