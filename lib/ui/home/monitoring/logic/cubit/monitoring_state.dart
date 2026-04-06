/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'monitoring_cubit.dart';

class MonitoringState extends Equatable {
  final ApiStatus getMonitoringStatus;
  final String getMonitoringError;
  final MonitoringResult? getMonitoringResult;

  const MonitoringState({
    this.getMonitoringStatus = ApiStatus.initial,
    this.getMonitoringError = '',
    this.getMonitoringResult,
  });

  MonitoringState copyWith({
    ApiStatus? getMonitoringStatus,
    String? getMonitoringError,
    MonitoringResult? getMonitoringResult,
  }) {
    return MonitoringState(
      getMonitoringStatus: getMonitoringStatus ?? this.getMonitoringStatus,
      getMonitoringError: getMonitoringError ?? this.getMonitoringError,
      getMonitoringResult: getMonitoringResult ?? this.getMonitoringResult,
    );
  }

  @override
  List<Object?> get props => [
    getMonitoringStatus,
    getMonitoringError,
    getMonitoringResult,
  ];
}
