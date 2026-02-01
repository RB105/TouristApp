/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:pinput/pinput.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/auth/create_password_screen.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
                    Pinput(
                      onCompleted: (value) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePasswordScreen(),));
                      },
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
  );
}
