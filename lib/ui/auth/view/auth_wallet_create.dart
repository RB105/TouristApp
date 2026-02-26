/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/home_screen.dart';
import 'package:touristapp/ui/home/main/logic/cubit/wallet_cubit.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart';
import 'package:touristapp/ui/widgets/app_loader.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_dialogs.dart';

class AuthWalletCreate extends StatefulWidget {
  const AuthWalletCreate({super.key});

  @override
  State<AuthWalletCreate> createState() => _AuthWalletCreateState();
}

class _AuthWalletCreateState extends State<AuthWalletCreate> {
  final WalletCubit _walletCubit = getIt<WalletCubit>();

  @override
  void initState() {
    _walletCubit.createWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _walletCubit,
      child: Scaffold(
        body: BlocListener<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state.walletCreateStatus == .success) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              });
            } else if (state.walletCreateStatus == .error) {
              // Show error dialog
              ModalDialogs.showErrorDialog(
                context,
                title: state.walletCreateError,
              );
            }
          },
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SvgPicture.asset(Assets.imagesWalletBg),
              ),
              SafeArea(
                child: Padding(
                  padding: context.k16Padding,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 32,
                        child: SvgPicture.asset(Assets.iconsAppLogo100X32Black),
                      ),
                      SizedBox(height: context.height * 0.1),
                      _buildRaw(
                        Assets.iconsPhoneDisabled,
                        "auth.phone_number".tr(),
                      ),
                      context.szBoxHeight20,
                      _buildRaw(
                        Assets.iconsVerification,
                        "auth.verification_code".tr(),
                      ),
                      context.szBoxHeight20,
                      _buildRaw(Assets.iconsPassword, "auth.password".tr()),
                      context.szBoxHeight20,
                      BlocBuilder<WalletCubit, WalletState>(
                        builder: (context, state) => Row(
                          crossAxisAlignment: .start,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: AppAnimatedSwitcher(
                                duration: Duration(milliseconds: 1200),
                                child: state.walletCreateStatus == .success
                                    ? SvgPicture.asset(Assets.iconsCheck)
                                    : AppLoader(),
                              ),
                            ),
                            context.szBoxWidth8,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  AppAnimatedSwitcher(
                                    duration: Duration(milliseconds: 1200),
                                    child: Text(
                                      state.walletCreateStatus == .success
                                          ? "Your wallet is ready!"
                                          : "Setting up your wallet",
                                      style: context.semiboldMd,
                                      key: ValueKey(state.walletCreateStatus),
                                    ),
                                  ),
                                  context.szBoxHeight8,
                                  AppAnimatedSwitcher(
                                    duration: Duration(milliseconds: 1200),
                                    child: Text(
                                      state.walletCreateStatus == .success
                                          ? "You now have a safe place\nfor your money."
                                          : "Hold tight while we're \ngetting your wallet ready.",
                                      style: context.semiboldMd.copyWith(
                                        color: context.textDisabled,
                                      ),
                                      key: ValueKey(state.walletCreateStatus),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRaw(String img, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 24, height: 24, child: SvgPicture.asset(img)),
        context.szBoxWidth8,
        Text(
          label,
          style: context.semiboldMd.copyWith(color: context.textDisabled),
        ),
      ],
    );
  }
}
