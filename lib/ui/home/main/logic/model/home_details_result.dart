/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';

class HomeDetailsResult {
  final List<Wallet> wallet;
  final List<MonitoringHistory> history;

  HomeDetailsResult({required this.wallet, required this.history});

  factory HomeDetailsResult.fromJson(Map<String, dynamic> json) {
    return HomeDetailsResult(
      wallet:
          (json['wallet'] as List?)?.map((e) => Wallet.fromJson(e)).toList() ??
          [],
      history:
          (json['history'] as List?)
              ?.map((e) => MonitoringHistory.fromJson(e))
              .toList() ??
          [],
    );
  }

  String getBalance() {
    if (wallet.isEmpty) {
      return "0 UZS";
    }
    return wallet.first.getBalance();
  }
}

class Wallet {
  final String? walletId;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final num? balance;
  final String? currency;
  final num? status;
  final String? description;

  Wallet({
    this.walletId,
    this.phone,
    this.firstName,
    this.lastName,
    this.balance,
    this.currency,
    this.status,
    this.description,
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

  String get getName {
    if ((firstName?.isEmpty ?? false) && (lastName?.isEmpty ?? false)) {
      return "No Name";
    } else if (firstName?.isEmpty ?? false) {
      return lastName ?? "";
    } else if (lastName?.isEmpty ?? false) {
      return firstName ?? "";
    }
    return fullName;
  }

  String getBalance() {
    String getCurrency() {
      if (currency == '860') {
        return "UZS";
      }
      return "";
    }

    final balanceInDouble =
        (balance ?? 100) / 100; // Assuming balance is in cents
    return "${balanceInDouble.toStringAsFixed(1)} ${getCurrency()}";
  }
}
