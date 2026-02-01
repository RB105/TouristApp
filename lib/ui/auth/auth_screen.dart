/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/otp_screen.dart';
import 'package:touristapp/ui/widgets/animated_switcher.dart';
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

  bool isValid = false;

  void updateFormat() {}

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MediaQuery.removeViewInsets(
              context: context,
              removeBottom: true,
              child: SvgPicture.asset(Assets.imagesState6, fit: BoxFit.cover),
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
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: SvgPicture.asset(Assets.iconsAuthPhone),
                      ),
                      Text("Phone number", style: context.boldDisplayXs),
                      context.szBoxHeight20,
                      Text(
                        "Enter your phone number to \nget confirmation code.",
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
                            "Password",
                            style: context.semiboldMd.copyWith(
                              color: context.textDisabled,
                            ),
                          ),
                        ],
                      ),
                      context.szBoxHeight24,
                      TextFormField(
                        controller: _phoneController,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onChanged: (value) {
                          // setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: context.bgElevated,
                          filled: true,
                          hintText: "Enter phone number",
                          hintStyle: context.mediumMutedMd.copyWith(
                            color: context.textDisabled,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: context.strokeBrand),
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                              width: 56,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: _phoneController.text.isEmpty
                                      ? context.bgMuted
                                      : context.primary,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => OtpScreen(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Center(
                                      child: AppAnimatedSwitcher(
                                        child: isValid
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
                              onSelected: (value) {},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: .center,
                                  crossAxisAlignment: .center,
                                  children: [
                                    // SizedBox(
                                    //   height: 24,
                                    //   width: 24,
                                    //   child: Image.asset(
                                    //     isRussia
                                    //         ? Assets.flagsRussia
                                    //         : Assets.flagsUzbekistan,
                                    //   ),
                                    // ),
                                    context.szBoxWidth4,
                                    Text("+998", style: context.mediumMd),
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
                                      // SizedBox(
                                      //   height: 24,
                                      //   width: 24,
                                      //   child: Image.asset(Assets.flagsUzbekistan),
                                      // ),
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
                                      // SizedBox(
                                      //   height: 24,
                                      //   width: 24,
                                      //   child: Image.asset(Assets.flagsRussia),
                                      // ),
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
    );
  }
}
