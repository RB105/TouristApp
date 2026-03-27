/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class TransactionResult {
  final String walletId;
  final double walletNewBalance;
  final String sender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String extId;
  final String refNum;
  final String status;
  final String description;
  final String receiver;
  final double commissionAmount;
  final String commissionCurrency;
  final String integrationType;
  final String flowType;
  final String provider;
  final num amount;
  final String currency;
  final String transactionDirection;

  TransactionResult({
    required this.walletId,
    required this.walletNewBalance,
    required this.sender,
    required this.createdAt,
    required this.updatedAt,
    required this.extId,
    required this.refNum,
    required this.status,
    required this.description,
    required this.receiver,
    required this.commissionAmount,
    required this.commissionCurrency,
    required this.integrationType,
    required this.flowType,
    required this.provider,
    required this.amount,
    required this.currency,
    required this.transactionDirection,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) {
    return TransactionResult(
      walletId: json['wallet_id'],
      walletNewBalance: (json['wallet_new_balance'] as num).toDouble(),
      sender: json['sender'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      extId: json['ext_id'],
      refNum: json['ref_num'],
      status: json['status'],
      description: json['description'],
      receiver: json['receiver'],
      commissionAmount: (json['commission_amount'] as num).toDouble(),
      commissionCurrency: json['commission_currency'],
      integrationType: json['integration_type'],
      flowType: json['flow_type'],
      provider: json['provider'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      transactionDirection: json['transaction_direction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet_id': walletId,
      'wallet_new_balance': walletNewBalance,
      'sender': sender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'ext_id': extId,
      'ref_num': refNum,
      'status': status,
      'description': description,
      'receiver': receiver,
      'commission_amount': commissionAmount,
      'commission_currency': commissionCurrency,
      'integration_type': integrationType,
      'flow_type': flowType,
      'provider': provider,
      'amount': amount,
      'currency': currency,
      'transaction_direction': transactionDirection,
    };
  }

  String get formattedCreatedAt {
    final d = createdAt;
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.'
        '${d.year} '
        '${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  }

  String getBalance() {
    String getCurrency() {
      if (currency == '860') {
        return "UZS";
      }
      return "";
    }

    final balanceInDouble = amount / 100; // Assuming balance is in cents
    return "${balanceInDouble.toStringAsFixed(1)} ${getCurrency()}";
  }

  factory TransactionResult.sample() {
    return TransactionResult.fromJson(_sample);
  }

  static const _sample = {
    "wallet_id": "BF20E032991443FFB42B12B3F4B8FE52",
    "wallet_new_balance": 850000,
    "sender": "None, None, None, 998974551041",
    "created_at": "2026-03-05T11:59:41.695266Z",
    "updated_at": "2026-03-05T11:59:44.835535Z",
    "ext_id": "tourist_ap_ext_id_1290a01e-274f-4dfd-859a-6595e488351e",
    "ref_num": "test_ref_number1234567890",
    "status": "SUCCESS",
    "description": "Success",
    "receiver": "01/043 MKA Маршрут № 51",
    "commission_amount": 0,
    "commission_currency": "860",
    "integration_type": "atto",
    "flow_type": "W2QR",
    "provider": "QR",
    "amount": 170000,
    "currency": "860",
    "transaction_direction": "OUT",
  };
}
