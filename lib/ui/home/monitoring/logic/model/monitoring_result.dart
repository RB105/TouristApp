/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import '../../../../../generated/assets.dart' show Assets;

enum TransactionStatus { created, pending, success, failed, canceled }

class MonitoringResult {
  final num? count;
  final num? currentPage;
  final num? next;
  final num? previous;
  final List<MonitoringHistory>? history;

  MonitoringResult({
    this.count,
    this.currentPage,
    this.next,
    this.previous,
    this.history,
  });

  factory MonitoringResult.fromJson(Map<String, dynamic> json) {
    return MonitoringResult(
      count: json['count'],
      currentPage: json['current_page'],
      next: json['next'],
      previous: json['previous'],
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => MonitoringHistory.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'current_page': currentPage,
      'next': next,
      'previous': previous,
      'history': history?.map((e) => e.toJson()).toList(),
    };
  }

  List<List<MonitoringHistory>> get groupAsNestedList {
    final map = <DateTime, List<MonitoringHistory>>{};

    for (final item in history ?? <MonitoringHistory>[]) {
      final dt = item.createdAt;
      if (dt == null) continue;

      final key = DateTime(dt.year, dt.month, dt.day);

      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(item);
    }

    // sort keys by descending date
    final sortedKeys = map.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    // return nested lists
    return sortedKeys.map((k) => map[k]!).toList();
  }
}

class MonitoringHistory {
  final int? id;
  final TypeDescription? typeDescription;
  final String? walletId;
  final double? walletNewBalance;
  final String? sender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? extId;
  final String? refNum;
  final String? status;
  final String? description;
  final String? receiver;
  final String? merchant;
  final String? organization;
  final String? terminal;
  final double? commissionAmount;
  final String? commissionCurrency;
  final String? integrationType;
  final String? flowType;
  final String? provider;
  final double? amount;
  final String? currency;
  final String? transactionDirection;

  MonitoringHistory({
    this.id,
    this.typeDescription,
    this.walletId,
    this.walletNewBalance,
    this.sender,
    this.createdAt,
    this.updatedAt,
    this.extId,
    this.refNum,
    this.status,
    this.description,
    this.receiver,
    this.merchant,
    this.organization,
    this.terminal,
    this.commissionAmount,
    this.commissionCurrency,
    this.integrationType,
    this.flowType,
    this.provider,
    this.amount,
    this.currency,
    this.transactionDirection,
  });

  factory MonitoringHistory.fromJson(Map<String, dynamic> json) {
    return MonitoringHistory(
      id: json['id'] as int?,
      typeDescription: json['type_description'] != null
          ? TypeDescription.fromJson(json['type_description'])
          : null,
      walletId: json['wallet_id'] as String?,
      walletNewBalance: (json['wallet_new_balance'] as num?)?.toDouble(),
      sender: json['sender'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      extId: json['ext_id'] as String?,
      refNum: json['ref_num'] as String?,
      status: json['status']?.toString(),
      description: json['description'] as String?,
      receiver: json['receiver'] as String?,
      merchant: json['merchant'] as String?,
      organization: json['organization'] as String?,
      terminal: json['terminal'] as String?,
      commissionAmount: (json['commission_amount'] as num?)?.toDouble(),
      commissionCurrency: json['commission_currency'] as String?,
      integrationType: json['integration_type'] as String?,
      flowType: json['flow_type'] as String?,
      provider: json['provider'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      transactionDirection: json['transaction_direction'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_description': typeDescription?.toJson(),
      'wallet_id': walletId,
      'wallet_new_balance': walletNewBalance,
      'sender': sender,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'ext_id': extId,
      'ref_num': refNum,
      'status': status,
      'description': description,
      'receiver': receiver,
      'merchant': merchant,
      'organization': organization,
      'terminal': terminal,
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

  // =========================
  // 🔹 Helpers
  // =========================

  String get formattedAmount {
    final amt = (amount ?? 0) / 100;

    switch (currency) {
      case "860":
        return "$amt UZS";
      case "643":
        return "$amt RUB";
      case "840":
      default:
        return "$amt USD";
    }
  }

  String get formattedTime {
    if (createdAt == null) return '';

    final hour = createdAt!.hour.toString().padLeft(2, '0');
    final minute = createdAt!.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  String get formattedDate {
    if (createdAt == null) return '';

    final day = createdAt!.day.toString().padLeft(2, '0');
    final month = createdAt!.month.toString().padLeft(2, '0');
    final year = createdAt!.year.toString();

    return '$day.$month.$year';
  }

  TransactionStatus get getTransactionStatus {
    if (status == '4') {
      return .success;
    } else if (status == '0') {
      return .created;
    } else if (status == '1') {
      return .pending;
    }

    return .failed;
  }

  String get getStateIcon {
    if (status == '4') {
      return Assets.iconsCheck;
    }

    if (status == '0' || status == '1') {
      return Assets.iconsProcessing;
    }

    return Assets.iconsClose;
  }

  /// Returns localized title based on app language
  String getTitle(String lang) {
    switch (lang) {
      case 'uz':
        return typeDescription?.uz ?? '';
      case 'ru':
        return typeDescription?.ru ?? '';
      case 'en':
      default:
        return typeDescription?.en ?? '';
    }
  }
}

class TypeDescription {
  final String? uz;
  final String? ru;
  final String? en;

  TypeDescription({this.uz, this.ru, this.en});

  String getDescription(String lang) {
    switch (lang) {
      case 'ru':
        return ru ?? "";
      case 'en':
        return en ?? "";
      case 'uz':
      default:
        return uz ?? "";
    }
  }

  factory TypeDescription.fromJson(Map<String, dynamic> json) {
    return TypeDescription(
      uz: json['uz'] as String?,
      ru: json['ru'] as String?,
      en: json['en'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'uz': uz, 'ru': ru, 'en': en};
  }
}
