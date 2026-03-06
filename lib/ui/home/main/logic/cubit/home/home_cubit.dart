/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:bloc/bloc.dart';
import 'package:touristapp/ui/home/main/logic/model/home_details_result.dart' show HomeDetailsResult;
import 'package:touristapp/ui/home/main/logic/service/home_service.dart';
import 'package:touristapp/utils/enums/api_status.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService): super(HomeState());

  final HomeService homeService;

  Future<void> getHomeDetails() async {
    emit(state.copyWith(homeDetailsStatus: .loading));

    final response = await homeService.getHomeDetails();

    if (response.isSuccess) {
      emit(state.copyWith(
        homeDetailsStatus: .success,
        details: response.data,
      ));
    } else {
      emit(state.copyWith(
        homeDetailsStatus: .error,
        homeDetailsError: response.error ?? "Unknown error",
      ));
    }
  }
}