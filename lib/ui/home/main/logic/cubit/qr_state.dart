/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'qr_cubit.dart';

class QrState extends Equatable {
  final ApiStatus qrCheckStatus;
  final String? qrCheckError;
  final QrCheckResult? qrCheckResult;

  //
  final ApiStatus paymentCreateStatus;
  final String paymentCreateError;

  //
  final ApiStatus paymentConfirmStatus;
  final String paymentConfirmError;
  final TransactionResult? transaction;

  const QrState({
    this.qrCheckStatus = .initial,
    this.qrCheckError,
    this.qrCheckResult,
    //
    this.paymentCreateStatus = .initial,
    this.paymentCreateError = '',
    //
    this.paymentConfirmStatus = .initial,
    this.paymentConfirmError = '',
    this.transaction,
  });

  QrState copyWith({
    ApiStatus? qrCheckStatus,
    String? qrCheckError,
    QrCheckResult? qrCheckResult,
    //
    ApiStatus? paymentCreateStatus,
    String? paymentCreateError,
    //
    ApiStatus? paymentConfirmStatus,
    String? paymentConfirmError,
    TransactionResult? transaction,
  }) {
    return QrState(
      qrCheckStatus: qrCheckStatus ?? this.qrCheckStatus,
      qrCheckError: qrCheckError ?? this.qrCheckError,
      qrCheckResult: qrCheckResult ?? this.qrCheckResult,
      //
      paymentCreateStatus: paymentCreateStatus ?? this.paymentCreateStatus,
      paymentCreateError: paymentCreateError ?? this.paymentCreateError,
      //
      paymentConfirmStatus: paymentConfirmStatus ?? this.paymentConfirmStatus,
      paymentConfirmError: paymentConfirmError ?? this.paymentConfirmError,
      transaction: transaction ?? this.transaction,
    );
  }

  @override
  List<Object?> get props => [
    qrCheckStatus,
    qrCheckError,
    qrCheckResult,
    //
    paymentCreateStatus,
    paymentCreateError,
    //
    paymentConfirmStatus,
    paymentConfirmError,
    transaction,
  ];
}
