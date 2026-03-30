/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/widgets/primary_container.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/modal/modal_dialogs.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBar(title: Text("home.profile_title".tr())),
    body: Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(Assets.imagesHomeBg, fit: .cover),
        ),
        SafeArea(
          child: Padding(
            padding: context.k16Padding,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("home.profile_title".tr(), style: context.semiboldMd),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ModalDialogs.showLogOutDialog(context);
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(Assets.iconsLogOutIcon),
                      ),
                    ),
                  ],
                ),

                context.szBoxHeight20,

                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(width: 3, color: context.primary),
                      ),
                    ),
                    context.szBoxWidth8,
                    Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        Text("+998 90 123 45 67", style: context.textMutedXs),
                        Text("Name"),
                      ],
                    ),
                  ],
                ),
                context.szBoxHeight16,
                PrimaryContainer(
                  padding: context.k12Padding,
                  children: [
                    _buildOptionsItem(
                      icon: Assets.iconsProfileOption,
                      title: "Personal information",
                      subtitle: "Name , Avatar",
                    ),
                    context.szBoxHeight4,
                    Divider(indent: 36),
                    context.szBoxHeight4,
                    _buildOptionsItem(
                      icon: Assets.iconsProfileOption,
                      title: "Preferences",
                      subtitle: "Theme, Language",
                    ),
                    context.szBoxHeight4,
                    Divider(indent: 36),
                    _buildOptionsItem(
                      icon: Assets.iconsProfileOption,
                      title: "Privacy",
                      subtitle: "Biometric, Password",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  SizedBox _buildOptionsItem({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: SvgPicture.asset(icon)),
          context.szBoxWidth16,
          Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Text(title, style: context.mediumMd),
              Text(subtitle, style: context.textMutedXs),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: context.textDisabled),
        ],
      ),
    );
  }
}
