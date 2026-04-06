/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class CaruselTransferServiceResult {
  final List<CaruselTransferService>? services;

  CaruselTransferServiceResult({this.services});

  factory CaruselTransferServiceResult.fromJson(Map<String, dynamic> json) {
    return CaruselTransferServiceResult(
      services: (json['services'] as List?)
          ?.map((e) => CaruselTransferService.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'services': services?.map((e) => e.toJson()).toList(),
    };
  }
}

class CaruselTransferService {
  final num? id;
  final num? providerId;
  final String? provider;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? type;
  final String? description;
  final num? minAmount;
  final num? maxAmount;
  final String? currency;
  final String? code;
  final bool? is3ds;
  final List<FieldModel>? fields;
  final List<dynamic>? responseFields;

  CaruselTransferService({
    this.id,
    this.providerId,
    this.provider,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.type,
    this.description,
    this.minAmount,
    this.maxAmount,
    this.currency,
    this.code,
    this.is3ds,
    this.fields,
    this.responseFields,
  });

  factory CaruselTransferService.fromJson(Map<String, dynamic> json) {
    return CaruselTransferService(
      id: json['id'],
      providerId: json['provider_id'],
      provider: json['provider'],
      nameUz: json['name_uz'],
      nameRu: json['name_ru'],
      nameEn: json['name_en'],
      type: json['type'],
      description: json['description'],
      minAmount: json['min_amount'],
      maxAmount: json['max_amount'],
      currency: json['currency'],
      code: json['code'],
      is3ds: json['is_3ds'],
      fields: (json['fields'] as List?)
          ?.map((e) => FieldModel.fromJson(e))
          .toList(),
      responseFields: json['response_fields'] as List?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_id': providerId,
      'provider': provider,
      'name_uz': nameUz,
      'name_ru': nameRu,
      'name_en': nameEn,
      'type': type,
      'description': description,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'currency': currency,
      'code': code,
      'is_3ds': is3ds,
      'fields': fields?.map((e) => e.toJson()).toList(),
      'response_fields': responseFields,
    };
  }

  String getName(String locale) {
    switch (locale) {
      case 'uz':
        return nameUz ?? "";
      case 'ru':
        return nameRu ?? "";
      case 'en':
        return nameEn ?? "";
      default:
        return nameEn ?? "";
    }
  }
}

class FieldModel {
  final num? id;
  final String? name;
  final String? labelUz;
  final String? labelRu;
  final String? labelEn;
  final String? type;
  final bool? isRequired;
  final num? order;
  final String? regex;

  FieldModel({
    this.id,
    this.name,
    this.labelUz,
    this.labelRu,
    this.labelEn,
    this.type,
    this.isRequired,
    this.order,
    this.regex,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      name: json['name'],
      labelUz: json['label_uz'],
      labelRu: json['label_ru'],
      labelEn: json['label_en'],
      type: json['type'],
      isRequired: json['is_required'],
      order: json['order'],
      regex: json['regex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'label_uz': labelUz,
      'label_ru': labelRu,
      'label_en': labelEn,
      'type': type,
      'is_required': isRequired,
      'order': order,
      'regex': regex,
    };
  }
}