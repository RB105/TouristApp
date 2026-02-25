/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/home_screen.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

class AuthWalletCreate extends StatefulWidget {
  const AuthWalletCreate({super.key});

  @override
  State<AuthWalletCreate> createState() => _AuthWalletCreateState();
}

class _AuthWalletCreateState extends State<AuthWalletCreate> {
  int? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(Assets.imagesWalletBg),
          ),
          SafeArea(
            child: Padding(
              padding: context.k16Padding,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 32,
                    child: SvgPicture.asset(Assets.iconsAppLogo100X32Black),
                  ),
                  context.szBoxHeight20,
                  Text("Select your wallet type", style: context.semiboldMd),
                  context.szBoxHeight20,
                  _cardWidget(
                    Assets.iconsUsCard,
                    () => setState(() => type = 1),
                    type == 1,
                  ),
                  context.szBoxHeight12,
                  _cardWidget(
                    Assets.iconsUzCard,
                    () => setState(() => type = 2),
                    type == 2,
                  ),
                  context.szBoxHeight12,
                  _cardWidget(
                    Assets.iconsRuCard,
                    () => setState(() => type = 3),
                    type == 3,
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: type != null
                            ? context.primary
                            : context.bgMuted,
                        foregroundColor: type != null
                            ? Colors.white
                            : context.textDisabled,
                      ),
                      onPressed: () {
                        if (type != null) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text("Set up"),
                    ),
                  ),
                  context.szBoxHeight20,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWidget(String img, GestureTapCallback onTap, bool isSelected) {
    return InkWell(
      borderRadius: context.borderRadius24,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: context.borderRadius24,
          border: Border.all(
            width: 2,
            color: isSelected ? context.primary : Colors.transparent,
          ),
        ),
        child: SvgPicture.asset(img, fit: BoxFit.cover),
      ),
    );
  }
}
