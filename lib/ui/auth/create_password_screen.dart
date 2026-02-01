/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/auth_confirm_screen.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart'
    show AppAnimatedSwitcher;
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  bool isObs1 = true;

  bool nextTapped = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: MediaQuery.removeViewInsets(
            context: context,
            removeBottom: true,
            child: SvgPicture.asset(Assets.imagesPasswordBg, fit: BoxFit.cover),
          ),
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
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(Assets.iconsPhoneDisabled),
                        ),
                        context.szBoxWidth8,
                        Text(
                          "Phone number",
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
                          child: SvgPicture.asset(Assets.iconsVerification),
                        ),
                        context.szBoxWidth8,
                        Text(
                          "Verification code",
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
                    Text("Password", style: context.boldDisplayXs),
                    context.szBoxHeight8,
                    Text(
                      "Create a password to secure your account.",
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
                          color: context.bgElevated
                        ),
                        child: Column(
                          mainAxisSize: .max,
                          children: [
                            TextFormField(
                              controller: _password1Controller,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                // setState(() {});
                              },
                              obscureText: isObs1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: context.k16Padding,
                                hintText: "Create new password",
                                hintStyle: context.mediumMutedMd.copyWith(
                                  color: context.textDisabled,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: context.strokeBrand,
                                  ),
                                  borderRadius: nextTapped ? BorderRadius.vertical(top: Radius.circular(28)) : BorderRadius.circular(28),
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
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisAlignment: nextTapped ? .end : .spaceBetween,
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
                                        onTap: () =>
                                            setState(() {
                                              isObs1 = !isObs1;
                                              // nextTapped = !nextTapped;
                                            }),
                                      ),
                                      AppAnimatedSwitcher(
                                        child: nextTapped ? SizedBox.shrink() : SizedBox(
                                          width: 56,
                                          height: 40,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color:
                                                  _password1Controller.text.isEmpty
                                                  ? context.bgMuted
                                                  : context.primary,
                                              borderRadius: BorderRadius.circular(
                                                28,
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                HapticFeedback.mediumImpact();
                                                setState(() {
                                                  nextTapped = !nextTapped;
                                                });
                                              },
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Center(
                                                  child: AppAnimatedSwitcher(
                                                    child: SvgPicture.asset(
                                                      Assets.iconsArrowForward,
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
                              child: nextTapped
                                  ? TextFormField(
                                      controller: _password2Controller,
                                      onTapOutside: (event) =>
                                          FocusScope.of(context).unfocus(),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      obscureText: isObs1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: context.bgElevated,
                                        filled: true,
                                        hintText: "Create new password",
                                        hintStyle: context.mediumMutedMd.copyWith(
                                          color: context.textDisabled,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: context.strokeBrand,
                                          ),
                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
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
                                        suffixIcon: Row(
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
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
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
                                                        BorderRadius.circular(28),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      HapticFeedback.mediumImpact();
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthConfirmScreen(),));
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
  );
}
