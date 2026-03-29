/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/logic/cubit/auth_cubit.dart';
import 'package:touristapp/ui/widgets/animated_auth_background.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart'
    show AppAnimatedSwitcher;
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_dialogs.dart' show ModalDialogs;
import 'package:touristapp/utils/router/app_router.dart' show MainRoute;

class LoginScreen extends StatefulWidget {
  final String phoneNumber;

  const LoginScreen({super.key, required this.phoneNumber});

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  final _password1Controller = TextEditingController();

  final _focusNode1 = FocusNode();

  bool isObs1 = true;

  final _authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    _focusNode1.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _password1Controller.dispose();
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _authCubit,
    child: Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.loginStatus == .loading) {
            ModalDialogs.showLoader(context);
          } else if (state.loginStatus == .error) {
            ModalDialogs.dismissCurrentDialog();
            ModalDialogs.showErrorDialog(
              context,
              title: state.loginErrorMessage,
            );
            debugPrint("Login Error: ${state.loginErrorMessage}");
          } else if (state.loginStatus == .success) {
            ModalDialogs.dismissCurrentDialog();
            MainRoute().go(context);
          }
        },
        builder: (context, state) => Stack(
          children: [
            Positioned.fill(
              child: AnimatedAuthBackground(svgAsset: Assets.imagesPasswordBg),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 32,
                      child: SvgPicture.asset(Assets.iconsAppLogo100X32Black),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                Assets.iconsPhoneDisabled,
                              ),
                            ),
                            context.szBoxWidth8,
                            Text(
                              "auth.phone_number".tr(),
                              style: context.semiboldMd.copyWith(
                                color: context.textDisabled,
                              ),
                            ),
                          ],
                        ),
                        context.szBoxHeight20,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(Assets.iconsVerification),
                            ),
                            context.szBoxWidth8,
                            Text(
                              "auth.verification_code".tr(),
                              style: context.semiboldMd.copyWith(
                                color: context.textDisabled,
                              ),
                            ),
                          ],
                        ),
                        context.szBoxHeight20,
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: SvgPicture.asset(Assets.iconsKey),
                        ),
                        Text(
                          "auth.password".tr(),
                          style: context.boldDisplayXs,
                        ),
                        context.szBoxHeight8,
                        Text(
                          "auth.login_password_desc".tr(),
                          style: context.textMd.copyWith(
                            color: context.textSecondary,
                          ),
                        ),
                        context.szBoxHeight24,
                        SizedBox(
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: context.bgElevated,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  focusNode: _focusNode1,
                                  controller: _password1Controller,
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  onChanged: (value) => setState(() {}),
                                  obscureText: isObs1,
                                  decoration: InputDecoration(
                                    contentPadding: context.k16Padding,
                                    hintText: "auth.login_password".tr(),
                                    hintStyle: context.mediumMutedMd.copyWith(
                                      color: context.textDisabled,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: context.strokeBrand,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(28),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIconConstraints: BoxConstraints(
                                      maxWidth: 100,
                                      maxHeight: 56,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: .spaceBetween,
                                        children: [
                                          InkWell(
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: SvgPicture.asset(
                                                isObs1
                                                    ? Assets.iconsEyeOn
                                                    : Assets.iconsEyeOff,
                                              ),
                                            ),
                                            onTap: () => setState(
                                              () => isObs1 = !isObs1,
                                            ),
                                          ),
                                          AppAnimatedSwitcher(
                                            child: SizedBox(
                                              width: 56,
                                              height: 40,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color:
                                                      _password1Controller
                                                          .text
                                                          .isEmpty
                                                      ? context.bgMuted
                                                      : context.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    HapticFeedback.mediumImpact();
                                                    _authCubit.login(
                                                      widget.phoneNumber,
                                                      _password1Controller.text,
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: Center(
                                                      child: AppAnimatedSwitcher(
                                                        child: SvgPicture.asset(
                                                          Assets
                                                              .iconsArrowForward,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        context.szBoxHeight20,
                      ],
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
