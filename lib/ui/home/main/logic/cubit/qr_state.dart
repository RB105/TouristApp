/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'qr_cubit.dart';

class QrState extends Equatable {
  final ApiStatus qrCheckStatus;
  final String? qrCheckError;
  final QrCheckResult? qrCheckResult;

  const QrState({
    this.qrCheckStatus = .initial,
    this.qrCheckError,
    this.qrCheckResult,
  });

  QrState copyWith({
    ApiStatus? qrCheckStatus,
    String? qrCheckError,
    QrCheckResult? qrCheckResult,
  }) {
    return QrState(
      qrCheckStatus: qrCheckStatus ?? this.qrCheckStatus,
      qrCheckError: qrCheckError ?? this.qrCheckError,
      qrCheckResult: qrCheckResult ?? this.qrCheckResult,
    );
  }

  @override
  List<Object?> get props => [];
}
