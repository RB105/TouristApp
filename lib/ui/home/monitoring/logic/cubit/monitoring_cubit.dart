/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touristapp/utils/enums/api_status.dart';

import '../model/monitoring_result.dart' show MonitoringResult;
import '../service/monitoring_service.dart' show MonitoringService;

part 'monitoring_state.dart';

class MonitoringCubit extends Cubit<MonitoringState> {
  MonitoringCubit(this._monitoringService) : super(const MonitoringState());

  final MonitoringService _monitoringService;

  Future<void> getMonitoring(int page) async {
    emit(state.copyWith(getMonitoringStatus: ApiStatus.loading));

    final response = await _monitoringService.getMonitoring(page);

    if (response.isSuccess) {
      emit(
        state.copyWith(
          getMonitoringStatus: ApiStatus.success,
          getMonitoringResult: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          getMonitoringStatus: ApiStatus.error,
          getMonitoringError: response.error.toString(),
        ),
      );
    }
  }
}