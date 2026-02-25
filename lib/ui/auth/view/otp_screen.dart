/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:pinput/pinput.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/logic/cubit/auth_cubit.dart';
import 'package:touristapp/ui/auth/view/register_screen.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_dialogs.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  final _focusNode = FocusNode();

  final AuthCubit _authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _authCubit,
    child: Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.confirmStatus == .success) {
            ModalDialogs.dismissCurrentDialog();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(
                    phoneNumber: widget.phoneNumber,
                    secretKey: state.secretKey ?? "",
                  ),
                ),
              );

          } else if (state.confirmStatus == .error) {
            ModalDialogs.dismissCurrentDialog();
            ModalDialogs.showErrorDialog(
              context,
              title: state.confirmErrorMessage ?? "",
            );
          } else if (state.confirmStatus == .loading) {
            // Optionally show a loading indicator
            ModalDialogs.showLoader(context);
          }
        },
        builder: (context, state) => Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(Assets.imagesState6, fit: .cover),
            ),
            SafeArea(
              child: Padding(
                padding: context.k16Padding,
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
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: SvgPicture.asset(
                            Assets.iconsVerificationActive,
                          ),
                        ),
                        Text(
                          "auth.verification_code".tr(),
                          style: context.boldDisplayXs,
                        ),
                        context.szBoxHeight20,
                        Text(
                          "auth.verification_message".tr(
                            namedArgs: {'phone': widget.phoneNumber},
                          ),
                          style: context.textMd.copyWith(
                            color: context.textSecondary,
                          ),
                        ),
                        context.szBoxHeight20,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(Assets.iconsPassword),
                            ),
                            context.szBoxWidth8,
                            Text(
                              "auth.password".tr(),
                              style: context.semiboldMd.copyWith(
                                color: context.textDisabled,
                              ),
                            ),
                          ],
                        ),
                        context.szBoxHeight24,
                        SizedBox(
                          height: 40,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: context.bgMuted,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "auth.resend_in".tr(
                                  namedArgs: {'seconds': '126'},
                                ),
                                style: context.textMd.copyWith(
                                  color: context.textDisabled,
                                ),
                              ),
                            ),
                          ),
                        ),
                        context.szBoxHeight24,
                        Pinput(
                          focusNode: _focusNode,
                          controller: _otpController,
                          onCompleted: (value) {
                            _authCubit.verifyOtp(
                              phone: widget.phoneNumber,
                              otp: _otpController.text,
                            );
                          },
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          length: 6,
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
