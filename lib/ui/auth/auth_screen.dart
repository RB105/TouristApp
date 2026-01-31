/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(Assets.imagesState6),
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
                        decoration: InputDecoration(
                          fillColor: context.bgElevated,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: context.strokeBrand),
                            borderRadius: BorderRadius.all(Radius.circular(28))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28))
                          ),
                        ),
                      ),
                      context.szBoxHeight20
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
