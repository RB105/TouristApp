/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:go_router/go_router.dart' show GoRouterHelper;
import 'package:touristapp/ui/widgets/asset_svg.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/router/app_router.dart';

import '../../../../generated/assets.dart' show Assets;
import '../../../../utils/di/di.dart' show getIt;
import '../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../widgets/animated_switcher.dart' show AppAnimatedSwitcher;
import '../../../widgets/shake_widget_anim.dart' show ShakeWidgetState;
import '../../logic/service/biometric_auth_service.dart'
    show BiometricAuthService;
import '../widgets/pin_code_indicators_raw.dart' show PinCodeIndicatorsRaw;
import '../widgets/pin_code_keyboar.dart' show PinCodeKeyboard;

enum PinStep {
  set, // set password
  confirm, // confirm password
  unlock, // overlay unlock
  signIn, // sign in after app start
}

class PinCodeScreen extends StatefulWidget {
  final PinStep initialStep;

  const PinCodeScreen({super.key, required this.initialStep});

  static const routeName = "/pin_code";

  static const String pinKey = "user_pin";

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final box = GetStorage();
  String input = "";
  String input2 = "";
  String? tempPin;
  String? _errorText;
  late PinStep step;
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final _shakeKey2 = GlobalKey<ShakeWidgetState>();
  late bool useBio = false;

  final _biometricAuth = getIt<BiometricAuthService>();

  @override
  void initState() {
    super.initState();
    step = widget.initialStep;
    debugPrint(step.toString());
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final available = await _biometricAuth.canCheckBiometrics();
    if (available && (step == PinStep.signIn || step == PinStep.unlock)) {
      setState(() => useBio = box.read("use_biometrics") ?? false);
      if (useBio) {
        _tryBiometricAuth();
      }
    }
  }

  Future<void> _tryBiometricAuth() async {
    final success = await _biometricAuth.authenticate();
    if (!mounted) return;

    if (success) {
      _onAuthSuccess();
    }
  }

  void _onAuthSuccess() {
    if (step == PinStep.unlock) {
      context.pop(true); // pop bottom sheet
    } else {
      MainRoute().go(context);
    }
  }

  void _onNumberTap(String num) {
    _errorText = null;
    if (step != .confirm) {
      if (input.length >= 5) return;
      setState(() => input += num);
      if (input.length == 5) {
        Future.delayed(const Duration(milliseconds: 200), _validate);
      }
    }

    if (step == .confirm) {
      if (input2.length >= 5) return;
      setState(() => input2 += num);
      if (input2.length == 5) {
        Future.delayed(const Duration(milliseconds: 200), _validate);
      }
    }
  }

  void _validate() async {
    final savedPin = box.read(PinCodeScreen.pinKey);

    if (step == PinStep.set) {
      tempPin = input;
      setState(() => step = PinStep.confirm);
    } else if (step == PinStep.confirm) {
      if (tempPin == input2) {
        box.write(PinCodeScreen.pinKey, input);

        final canUseBio = await _biometricAuth.canCheckBiometrics();
        if (canUseBio) {
          final success = await _biometricAuth.authenticate();
          if (success) {
            await box.write("use_biometrics", true);
          } else {
            await box.write("use_biometrics", false);
          }
        }
        // ignore: use_build_context_synchronously
        MainRoute().go(context);
      } else {
        _errorText = "auth.pins_do_not_match".tr();
        step = .set;
        input = "";
        input2 = "";
        _shakeKey2.currentState?.shake();
        setState(() {});
      }
    } else if (step == PinStep.unlock || step == PinStep.signIn) {
      if (savedPin == input) {
        _onAuthSuccess();
      } else {
        _errorText = "auth.incorrect_pin".tr();
        input = "";
        _shakeKey.currentState?.shake();
        setState(() {});
      }
    }
  }

  void _onDelete() {
    if (input.isNotEmpty && step != .confirm) {
      setState(() => input = input.substring(0, input.length - 1));
    } else if (input2.isNotEmpty && step == .confirm) {
      setState(() {
        input2 = input2.substring(0, input2.length - 1);
        if (input2.isEmpty) {
          step = .set;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(Assets.imagesPinCodeBg, fit: .cover),
          ),
          SafeArea(
            child: Padding(
              padding: context.k16Padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // top content
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 32,
                              child: SvgPicture.asset(
                                Assets.iconsAppLogo100X32Black,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                // ModalDialogs.showLogoutDialog(context);
                              },
                              child: Text("auth.cant_login".tr()),
                            ),
                          ],
                        ),
                        context.szBoxFromHeight(128),
                        AssetSvg(Assets.iconsLock),
                        context.szBoxHeight8,
                        Text(
                          step == PinStep.set
                              ? "auth.set_pin".tr()
                              : step == PinStep.confirm
                              ? "auth.confirm_pin".tr()
                              : "auth.enter_pin".tr(),
                          style: context.boldDisplayXs, //b18W500H24Manrope
                          textAlign: TextAlign.center,
                        ),
                        context.szBoxHeight24,
                        PinCodeIndicatorsRaw(shakeKey: _shakeKey, input: input),
                        AppAnimatedSwitcher(
                          child: step == .confirm
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: PinCodeIndicatorsRaw(
                                    shakeKey: _shakeKey2,
                                    input: input2,
                                  ),
                                )
                              : SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: AppAnimatedSwitcher(
                            child: _errorText != null
                                ? Text(
                                    _errorText!,
                                    style: context.textMd.copyWith(
                                      color: context.error,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric().copyWith(
                        bottom: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PinCodeKeyboard(
                            leftButtonFn: useBio ? _tryBiometricAuth : null,
                            leftIcon: useBio
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SvgPicture.asset(
                                      Assets.iconsFaceIdIos,
                                    ),
                                  )
                                : null,
                            rightButtonFn: _onDelete,
                            rightIcon: Icon(
                              Icons.backspace,
                              color: context.textSecondary,
                            ),
                            onKeyboardTap: (text) {
                              HapticFeedback.lightImpact();
                              _onNumberTap(text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
