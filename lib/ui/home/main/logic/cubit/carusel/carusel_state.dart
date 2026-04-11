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
  //
  final ApiStatus transactionStateStatus;
  final String transactionStateError;
  final MonitoringHistory? transactionState;

  const CaruselState({
    this.transferServiceStatus = ApiStatus.initial,
    this.transferServiceError = '',
    this.transferServiceResult,
    //
    this.transferCreateStatus = .initial,
    this.transferCreateError = '',
    this.transferCreateSbpResult,
    //
    this.transactionStateStatus = .initial,
    this.transactionStateError = '',
    this.transactionState
    //

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
    //
    transactionStateStatus,
    transactionStateError,
    transactionState
  ];

  CaruselState copyWith({
    ApiStatus? transferServiceStatus,
    String? transferServiceError,
    CaruselTransferServiceResult? transferServiceResult,
    //
    ApiStatus? transferCreateStatus,
    String? transferCreateError,
    TransferCreateSbpResult? transferCreateSbpResult,
    //
    ApiStatus? transactionStateStatus,
    String? transactionStateError,
    MonitoringHistory? transactionState,
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
      //
      transactionStateStatus: transactionStateStatus ?? this.transactionStateStatus,
      transactionStateError: transactionStateError ?? this.transactionStateError,
      transactionState: transactionState ?? this.transactionState
    );
  }
}
