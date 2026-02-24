/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/logic/cubit/auth_cubit.dart';
import 'package:touristapp/ui/home/home_screen.dart';
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

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;
  final String secretKey;

  const RegisterScreen({
    super.key,
    required this.phoneNumber,
    required this.secretKey,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  bool isObs1 = true;
  bool isObs2 = true;

  bool nextTapped = false;

  final AuthCubit _authCubit = getIt<AuthCubit>();

  bool get _isValid => false;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider.value(
      value: _authCubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
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
                          "auth.create_password".tr(),
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
                                  onChanged: (value) {
                                    if (value.isEmpty) nextTapped = false;
                                    setState(() {});
                                  },
                                  obscureText: isObs1,
                                  decoration: InputDecoration(
                                    contentPadding: context.k16Padding,
                                    hintText: "auth.create_new_password".tr(),
                                    hintStyle: context.mediumMutedMd.copyWith(
                                      color: context.textDisabled,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: context.strokeBrand,
                                      ),
                                      borderRadius: nextTapped
                                          ? BorderRadius.vertical(
                                              top: Radius.circular(28),
                                            )
                                          : BorderRadius.circular(28),
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
                                        mainAxisAlignment: nextTapped
                                            ? .end
                                            : .spaceBetween,
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
                                            onTap: () => setState(() {
                                              isObs1 = !isObs1;
                                              // nextTapped = !nextTapped;
                                            }),
                                          ),
                                          AppAnimatedSwitcher(
                                            child: nextTapped
                                                ? SizedBox.shrink()
                                                : SizedBox(
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
                                                            BorderRadius.circular(
                                                              28,
                                                            ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          HapticFeedback.mediumImpact();
                                                          setState(() {
                                                            nextTapped = true;
                                                          });
                                                          _focusNode2
                                                              .requestFocus();
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
                                AppAnimatedSwitcher(
                                  child:
                                      nextTapped &&
                                          _password1Controller.text.isNotEmpty
                                      ? TextFormField(
                                          focusNode: _focusNode2,
                                          controller: _password2Controller,
                                          onTapOutside: (event) =>
                                              FocusScope.of(context).unfocus(),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          obscureText: isObs2,
                                          decoration: InputDecoration(
                                            fillColor: context.bgElevated,
                                            filled: true,
                                            hintText:
                                                "auth.confirm_new_password"
                                                    .tr(),
                                            hintStyle: context.mediumMutedMd
                                                .copyWith(
                                                  color: context.textDisabled,
                                                ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: context.strokeBrand,
                                              ),
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    bottom: Radius.circular(28),
                                                  ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(28),
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            suffixIconConstraints:
                                                BoxConstraints(
                                                  maxWidth: 100,
                                                  maxHeight: 56,
                                                ),
                                            suffixIcon: Row(
                                              mainAxisAlignment: .spaceBetween,
                                              children: [
                                                InkWell(
                                                  child: SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: SvgPicture.asset(
                                                      isObs2
                                                          ? Assets.iconsEyeOn
                                                          : Assets.iconsEyeOff,
                                                    ),
                                                  ),
                                                  onTap: () => setState(
                                                    () => isObs2 = !isObs2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    6.0,
                                                  ),
                                                  child: SizedBox(
                                                    width: 56,
                                                    height: 40,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            _password2Controller
                                                                .text
                                                                .isEmpty
                                                            ? context.bgMuted
                                                            : context.primary,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              28,
                                                            ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          HapticFeedback.mediumImpact();
                                                          if(_isValid) {
                                                            // _authCubit
                                                          }
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
                                        )
                                      : SizedBox(),
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
