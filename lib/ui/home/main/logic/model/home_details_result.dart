/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class HomeDetailsResult {
  final List<Wallet> wallet;
  final List<HistoryGroup> history;

  HomeDetailsResult({required this.wallet, required this.history});

  factory HomeDetailsResult.fromJson(Map<String, dynamic> json) {
    return HomeDetailsResult(
      wallet: (json['wallet'] as List).map((e) => Wallet.fromJson(e)).toList(),
      history: (json['history'] as List)
          .map((e) => HistoryGroup.fromJson(e))
          .toList(),
    );
  }
}

class Wallet {
  final String walletId;
  final String phone;
  final String firstName;
  final String lastName;
  final int balance;
  final String currency;
  final int status;
  final String description;

  Wallet({
    required this.walletId,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.balance,
    required this.currency,
    required this.status,
    required this.description,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletId: json['wallet_id'],
      phone: json['phone'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      balance: json['balance'],
      currency: json['currency'],
      status: json['status'],
      description: json['description'],
    );
  }

  String get fullName => "$firstName $lastName";

  String getBalance() {
    final balanceInDouble = balance / 100; // Assuming balance is in cents
    return "$balanceInDouble $currency";
  }
}

class HistoryGroup {
  final String date;
  final List<TransactionItem> items;

  HistoryGroup({required this.date, required this.items});

  factory HistoryGroup.fromJson(Map<String, dynamic> json) {
    return HistoryGroup(
      date: json['date'],
      items: (json['items'] as List)
          .map((e) => TransactionItem.fromJson(e))
          .toList(),
    );
  }
}

class TransactionItem {
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
  final int amount;
  final String currency;
  final String transactionDirection;

  TransactionItem({
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

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      walletId: json['wallet_id'],
      walletNewBalance: json['wallet_new_balance'] ?? 0.0,
      sender: json['sender'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      extId: json['ext_id'],
      refNum: json['ref_num'],
      status: json['status'],
      description: json['description'],
      receiver: json['receiver'],
      commissionAmount: json['commission_amount'],
      commissionCurrency: json['commission_currency'],
      integrationType: json['integration_type'],
      flowType: json['flow_type'],
      provider: json['provider'],
      amount: json['amount'],
      currency: json['currency'],
      transactionDirection: json['transaction_direction'],
    );
  }

  bool get isSuccess => status == "SUCCESS";
}
