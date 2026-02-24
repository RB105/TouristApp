/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:easy_localization/easy_localization.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/logic/cubit/auth_cubit.dart';
import 'package:touristapp/ui/auth/view/otp_screen.dart' show OtpScreen;

import 'package:touristapp/ui/widgets/animated_auth_background.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/enums/api_status.dart' show ApiStatus;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String iso = 'UZ';
  late TextInputFormatter _phoneFormatter;

  bool get _isValid {
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) return false;

    if (iso == 'UZ') {
      return digits.length == 9;
    }

    if (iso == 'RU') {
      return digits.length == 10;
    }

    return false;
  }

  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();

  final AuthCubit _authCubit = getIt<AuthCubit>();

  final Map<String, TextInputFormatter> _formattersByIso = {
    'UZ': _MaskedNumberFormatter(mask: '## ### ## ##'), // +998
    'RU': _MaskedNumberFormatter(mask: '### ### ## ##'), // +7
  };

  String _getPhoneNumber() {
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (iso == 'UZ') {
      return '998$digits';
    } else if (iso == 'RU') {
      return '7$digits';
    }
    return '';
  }

  void updateFormat(String nextIso) {
    if (iso == nextIso || !_formattersByIso.containsKey(nextIso)) return;
    setState(() {
      iso = nextIso;
      _phoneFormatter = _formattersByIso[nextIso]!;
      _phoneController.clear();
    });
  }

  @override
  void initState() {
    _phoneFormatter = _formattersByIso[iso]!;
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.registerStatus == ApiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "errors.error_unknown".tr()),
              ),
            );
          } else if (state.registerStatus == ApiStatus.success) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  phoneNumber: _getPhoneNumber(),
                  secretKey: state.secretKey ?? "",
                ),
              ),
            );
          }
        },
        builder: (context, state) => Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: AnimatedAuthBackground(svgAsset: Assets.imagesState6),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 32,
                        child: SvgPicture.asset(Assets.iconsAppLogo100X32Black),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: SvgPicture.asset(Assets.iconsAuthPhone),
                          ),
                          Text("auth.phone_number".tr(), style: context.boldDisplayXs),
                          context.szBoxHeight20,
                          Text(
                            "auth.enter_phone".tr(),
                            style: context.textMd.copyWith(
                              color: context.textSecondary,
                            ),
                          ),
                          context.szBoxHeight20,
                          Row(
                            crossAxisAlignment: .center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  Assets.iconsVerification,
                                ),
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
                          Row(
                            crossAxisAlignment: .center,
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
                          TextFormField(
                            focusNode: _focusNode,
                            controller: _phoneController,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [_phoneFormatter],
                            decoration: InputDecoration(
                              fillColor: context.bgElevated,
                              filled: true,
                              hintText: "auth.enter_phone_placeholder".tr(),
                              hintStyle: context.mediumMutedMd.copyWith(
                                color: context.textDisabled,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.strokeBrand,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(28),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(28),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Padding(
                                padding: context.k8Padding,
                                child: SizedBox(
                                  width: 56,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: _phoneController.text.isEmpty
                                          ? context.bgMuted
                                          : context.primary,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (_isValid) {
                                          HapticFeedback.mediumImpact();
                                          _authCubit.register(
                                            phone: _getPhoneNumber(),
                                          );
                                        }
                                      },
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Center(
                                          child: AppAnimatedSwitcher(
                                            child:
                                                state.registerStatus == .loading
                                                ? SizedBox(
                                                    width: 14,
                                                    height: 14,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 1.5,
                                                        ),
                                                  )
                                                : SvgPicture.asset(
                                                    Assets.iconsArrowForward,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                maxHeight: 50,
                                maxWidth: 90,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsetsGeometry.zero,
                                  color: context.bgElevated,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onSelected: updateFormat,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: .center,
                                      crossAxisAlignment: .center,
                                      children: [
                                        context.szBoxWidth4,
                                        Text(
                                          iso == 'RU' ? "+7" : "+998",
                                          style: context.mediumMd,
                                        ),
                                        context.szBoxWidth2,
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "UZ",
                                      child: Row(
                                        mainAxisAlignment: .start,
                                        crossAxisAlignment: .center,
                                        children: [
                                          context.szBoxWidth4,
                                          Text("+998", style: context.mediumMd),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "RU",
                                      child: Row(
                                        mainAxisAlignment: .start,
                                        crossAxisAlignment: .center,
                                        children: [
                                          context.szBoxWidth4,
                                          Text("+7", style: context.mediumMd),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
}

// Lightweight mask formatter using '#' as digit placeholder.
class _MaskedNumberFormatter extends TextInputFormatter {
  _MaskedNumberFormatter({required this.mask});

  final String mask;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    var digitIndex = 0;

    for (int i = 0; i < mask.length && digitIndex < digits.length; i++) {
      final ch = mask[i];
      if (ch == '#') {
        buffer.write(digits[digitIndex++]);
      } else {
        buffer.write(ch);
      }
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
