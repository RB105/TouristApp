/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'carusel_cubit.dart';

class CaruselState extends Equatable {
  final ApiStatus transferServiceStatus;
  final String transferServiceError;
  final CaruselTransferServiceResult? transferServiceResult;

  //
  final ApiStatus transferCreateStatus;
  final String transferCreateError;
  final TransferCreateSbpResult? transferCreateSbpResult;

  const CaruselState({
    this.transferServiceStatus = ApiStatus.initial,
    this.transferServiceError = '',
    this.transferServiceResult,
    //
    this.transferCreateStatus = .initial,
    this.transferCreateError = '',
    this.transferCreateSbpResult,
  });

  @override
  List<Object?> get props => [
    transferServiceStatus,
    transferServiceError,
    transferServiceResult,
    //
    transferCreateStatus,
    transferCreateError,
    transferCreateSbpResult,
  ];

  CaruselState copyWith({
    ApiStatus? transferServiceStatus,
    String? transferServiceError,
    CaruselTransferServiceResult? transferServiceResult,
    //
    ApiStatus? transferCreateStatus,
    String? transferCreateError,
    TransferCreateSbpResult? transferCreateSbpResult,
  }) {
    return CaruselState(
      transferServiceStatus:
          transferServiceStatus ?? this.transferServiceStatus,
      transferServiceError: transferServiceError ?? this.transferServiceError,
      transferServiceResult:
          transferServiceResult ?? this.transferServiceResult,
      //
      transferCreateStatus: transferCreateStatus ?? this.transferCreateStatus,
      transferCreateError: transferCreateError ?? this.transferCreateError,
      transferCreateSbpResult:
          transferCreateSbpResult ?? this.transferCreateSbpResult,
    );
  }
}
