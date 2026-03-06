/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'home_cubit.dart';

class HomeState {
  final ApiStatus homeDetailsStatus;
  final String homeDetailsError;
  final HomeDetailsResult? details;

  HomeState({
    this.details,
    this.homeDetailsStatus = .initial,
    this.homeDetailsError = '',
  });

  HomeState copyWith({
    ApiStatus? homeDetailsStatus,
    String? homeDetailsError,
    HomeDetailsResult? details,
  }) {
    return HomeState(
      homeDetailsError: homeDetailsError ?? this.homeDetailsError,
      homeDetailsStatus: homeDetailsStatus ?? this.homeDetailsStatus,
      details: details ?? this.details,
    );
  }
}
