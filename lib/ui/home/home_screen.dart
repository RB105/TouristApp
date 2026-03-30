/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell shell;

  const HomeScreen({super.key, required this.shell});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: context.mediumMutedMd,
        selectedLabelStyle: context.mediumMd,
        selectedItemColor: context.primary,
        unselectedItemColor: const Color(0xFF9CA3AF),
        currentIndex: widget.shell.currentIndex,
        type: .fixed,
        onTap: (index) => widget.shell.goBranch(index),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarMain, 0),
            label: "home.main_nav_title".tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarChat, 1),
            label: "home.chat_nav_title".tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarMonitoring, 2),
            label: "home.monitoring_nav_title".tr(),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                widget.shell.currentIndex == 3
                    ? Assets.iconsAvatarEnabled
                    : Assets.iconsAvatarDisabled,
              ),
            ),
            label: "home.profile_nav_title".tr(),
          ),
        ],
      ),
    );
  }

  SizedBox _buildNavbar(String img, int index) => SizedBox(
    width: 24,
    height: 24,
    child: SvgPicture.asset(
      img,
      colorFilter: ColorFilter.mode(
        widget.shell.currentIndex == index
            ? context.primary
            : context.iconDisabled,
        .srcIn,
      ),
    ),
  );
}
