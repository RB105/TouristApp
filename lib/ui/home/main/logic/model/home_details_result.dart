/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class HomeDetailsResult {
  final List<Wallet> wallet;
  final List<HistoryGroup> history;

  HomeDetailsResult({
    required this.wallet,
    required this.history,
  });

  factory HomeDetailsResult.fromJson(Map<String, dynamic> json) {
    return HomeDetailsResult(
      wallet: (json['wallet'] as List)
          .map((e) => Wallet.fromJson(e))
          .toList(),
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

  HistoryGroup({
    required this.date,
    required this.items,
  });

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
  final int id;
  final String time;
  final String direction;
  final String amount;
  final String sign;
  final String currency;
  final String status;
  final String title;
  final String provider;
  final String flow;
  final String counterpartyName;
  final String counterpartyMask;

  TransactionItem({
    required this.id,
    required this.time,
    required this.direction,
    required this.amount,
    required this.sign,
    required this.currency,
    required this.status,
    required this.title,
    required this.provider,
    required this.flow,
    required this.counterpartyName,
    required this.counterpartyMask,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'],
      time: json['time'],
      direction: json['direction'],
      amount: json['amount'],
      sign: json['sign'],
      currency: json['currency'],
      status: json['status'].toString(),
      title: json['title'],
      provider: json['provider'],
      flow: json['flow'],
      counterpartyName: json['counterparty_name'],
      counterpartyMask: json['counterparty_mask'],
    );
  }

  double get parsedAmount => double.tryParse(amount) ?? 0;

  bool get isSuccess => status == "SUCCESS" || status == "4";
}