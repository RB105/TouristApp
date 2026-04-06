/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

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
    final sortedKeys = map.keys.toList()..sort((a, b) => b.compareTo(a));

    // return nested lists
    return sortedKeys.map((k) => map[k]!).toList();
  }
}

class MonitoringHistory {
  final num? id;
  final String? walletId;
  final num? walletNewBalance;
  final String? sender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? extId;
  final String? refNum;
  final String? status;
  final String? description;
  final String? receiver;
  final num? commissionAmount;
  final String? commissionCurrency;
  final String? integrationType;
  final String? flowType;
  final String? provider;
  final num? amount;
  final String? currency;
  final String? transactionDirection;

  MonitoringHistory({
    this.id,
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
      id: json['id'],
      walletId: json['wallet_id'],
      walletNewBalance: json['wallet_new_balance'],
      sender: json['sender'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
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

  String get getAmount {
    switch (currency) {
      case "860":
        return "$amount UZS";
      case "643":
        return "$amount RUB";
      case "840":
      default:
        return "$amount USD";
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'wallet_new_balance': walletNewBalance,
      'sender': sender,
      'created_at': createdAt,
      'updated_at': updatedAt,
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

  String get getCreateDateTime {
    if (createdAt == null) return '';

    final hour = createdAt?.hour.toString().padLeft(2, '0');
    final minute = createdAt?.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  /// formates create date **DD.MM.YYYY**
  String formatCreateDate() {
    if (createdAt == null) return '';

    final day = createdAt!.day.toString().padLeft(2, '0');
    final month = createdAt!.month.toString().padLeft(2, '0');
    final year = createdAt!.year.toString();

    return '$day.$month.$year';
  }
}
