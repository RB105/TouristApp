/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final ApiStatus walletCreateStatus;
  final String walletCreateError;

  const WalletState({
    this.walletCreateStatus = ApiStatus.initial,
    this.walletCreateError = "",
  });

  WalletState copyWith({
    ApiStatus? walletCreateStatus,
    String? walletCreateError,
  }) {
    return WalletState(
      walletCreateStatus: walletCreateStatus ?? this.walletCreateStatus,
      walletCreateError: walletCreateError ?? this.walletCreateError,
    );
  }

  @override
  List<Object?> get props => [walletCreateStatus, walletCreateError];
}
