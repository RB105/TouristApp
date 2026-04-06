/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class TransferCreateSbpResult {
  final String? extId;
  final num? state;
  final String? description;
  final num? amount;
  final String? currency;
  final num? commission;
  final num? crAmount;
  final String? crCurrency;
  final String? formUrl;
  final List<BankInfo>? banks;

  TransferCreateSbpResult({
    this.extId,
    this.state,
    this.description,
    this.amount,
    this.currency,
    this.commission,
    this.crAmount,
    this.crCurrency,
    this.formUrl,
    this.banks,
  });

  factory TransferCreateSbpResult.fromJson(Map<String, dynamic> json) {
    return TransferCreateSbpResult(
      extId: json['ext_id'],
      state: json['state'],
      description: json['description'],
      amount: json['amount'],
      currency: json['currency'],
      commission: json['commission'],
      crAmount: json['cr_amount'],
      crCurrency: json['cr_currency'],
      formUrl: json['form_url'],
      banks: (json['banks'] as List<dynamic>?)
          ?.map((e) => BankInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ext_id': extId,
      'state': state,
      'description': description,
      'amount': amount,
      'currency': currency,
      'commission': commission,
      'cr_amount': crAmount,
      'cr_currency': crCurrency,
      'form_url': formUrl,
      'banks': banks?.map((e) => e.toJson()).toList(),
    };
  }
}

class BankInfo {
  final String? code;
  final String? name;

  BankInfo({
    this.code,
    this.name,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}