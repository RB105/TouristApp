/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/utils/extensions/color_extension.dart' show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart' show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class AuthConfirmScreen extends StatefulWidget {
  const AuthConfirmScreen({super.key});

  @override
  State<AuthConfirmScreen> createState() => _AuthConfirmScreenState();
}

class _AuthConfirmScreenState extends State<AuthConfirmScreen> {
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
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: SvgPicture.asset(Assets.iconsVerificationActive),
                    ),
                    Text("Verification code", style: context.boldDisplayXs),
                    context.szBoxHeight20,
                    Text(
                      "We’ve sent you a 6-digit code to\n+99897 *** ** 67 via Telegram.\nPlease check out “Verification Codes” chat",
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
                            "Resend in 126 sec",
                            style: context.textMd.copyWith(
                              color: context.textDisabled,
                            ),
                          ),
                        ),
                      ),
                    ),
                    context.szBoxHeight24,
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
