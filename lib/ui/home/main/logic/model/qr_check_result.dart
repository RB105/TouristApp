/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class QrCheckResult {
  final String extId;
  final String qrId;
  final String traceId;
  final int rate;
  final String terminalExtId;
  final String type;
  final String purpose;
  final DateTime? createdAt;
  final DateTime? expireDate;
  final String status;
  final String? mfo;
  final String? mcc;
  final dynamic merchantInfo;
  final int amount;
  final String currency;
  final int settlementAmount;
  final String settlementCurrency;
  final String? settlementCurrencyName;
  final int minAmount;
  final int maxAmount;
  final String merchant;
  final String integrationType;

  QrCheckResult({
    required this.extId,
    required this.qrId,
    required this.traceId,
    required this.rate,
    required this.terminalExtId,
    required this.type,
    required this.purpose,
    required this.createdAt,
    required this.expireDate,
    required this.status,
    required this.mfo,
    required this.mcc,
    required this.merchantInfo,
    required this.amount,
    required this.currency,
    required this.settlementAmount,
    required this.settlementCurrency,
    required this.settlementCurrencyName,
    required this.minAmount,
    required this.maxAmount,
    required this.merchant,
    required this.integrationType,
  });

  factory QrCheckResult.fromJson(Map<String, dynamic> json) {
    return QrCheckResult(
      extId: json['ext_id'] ?? json['extId'],
      qrId: json['qr_id'] ?? json['qrId'],
      traceId: json['trace_id'] ?? json['traceId'],
      rate: json['rate'] ?? 0,
      terminalExtId:
      json['terminal_ext_id'] ?? json['terminalExtId'],
      type: json['type'],
      purpose: json['purpose'],
      createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
      expireDate: _parseDate(json['expire_date'] ?? json['expireDate']),
      status: json['status'],
      mfo: json['mfo'],
      mcc: json['mcc'],
      merchantInfo: json['merchant_info'],
      amount: json['amount'],
      currency: json['currency'],
      settlementAmount:
      json['settlement_amount'],
      settlementCurrency:
      json['settlement_currency'],
      settlementCurrencyName:
      json['settlement_currency_name'],
      minAmount: json['min_amount'],
      maxAmount: json['max_amount'],
      merchant: json['merchant'],
      integrationType: json['integration_type'],
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'ext_id': extId,
      'qr_id': qrId,
      'trace_id': traceId,
      'rate': rate,
      'terminal_ext_id': terminalExtId,
      'type': type,
      'purpose': purpose,
      'created_at': createdAt?.toIso8601String(),
      'expire_date': expireDate?.toIso8601String(),
      'status': status,
      'mfo': mfo,
      'mcc': mcc,
      'merchant_info': merchantInfo,
      'amount': amount,
      'currency': currency,
      'settlement_amount': settlementAmount,
      'settlement_currency': settlementCurrency,
      'settlement_currency_name': settlementCurrencyName,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'merchant': merchant,
      'integration_type': integrationType,
    };
  }
}