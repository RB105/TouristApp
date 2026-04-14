/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

class PaymentCreateResult {
  final String extId;
  final String status;
  final String description;
  final String phoneNumber;
  final String? refNum;
  final bool? otpRequired;
  final int? otpCodeLength;
  final int? expireTimeOtpCode;

  PaymentCreateResult({
    required this.extId,
    required this.status,
    required this.description,
    this.refNum,
    required this.phoneNumber,
    required this.otpRequired,
    this.otpCodeLength,
    this.expireTimeOtpCode,
  });

  factory PaymentCreateResult.fromJson(Map<String, dynamic> json) {
    return PaymentCreateResult(
      extId: json['ext_id'] as String,
      status: json['status'].toString(),
      description: json['description'] as String,
      refNum: json['ref_num'] as String?,
      phoneNumber: json['phone_number'].toString(),
      otpRequired: json['otp_requared'] ?? false,
      otpCodeLength: json['otp_code_length'] ?? 0,
      expireTimeOtpCode: json['expire_time_otp_code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ext_id': extId,
      'status': status,
      'description': description,
      'ref_num': refNum,
      'phone_number': phoneNumber,
      'otp_requared': otpRequired,
      'otp_code_length': otpCodeLength,
      'expire_time_otp_code': expireTimeOtpCode,
    };
  }

  @override
  String toString() {
    return "PaymentCreateResult(extId: $extId, status: $status, description: $description, refNum: $refNum, phoneNumber: $phoneNumber, otpRequired: $otpRequired, otpCodeLength: $otpCodeLength, expireTimeOtpCode: $expireTimeOtpCode)";
  }
}
