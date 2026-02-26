/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/home/chat/chat_screen.dart';
import 'package:touristapp/ui/home/main/main_screen.dart';
import 'package:touristapp/ui/home/monitoring/monitoring_screen.dart';
import 'package:touristapp/ui/home/profile/profile_screen.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _pages = [
    MainScreen(),
    ChatScreen(),
    MonitoringScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: context.mediumMutedMd,
        selectedItemColor: context.primary,
        unselectedItemColor: const Color(0xFF9CA3AF),
        currentIndex: currentIndex,
        type: .fixed,
        onTap: (value) => setState(() => currentIndex = value),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarMain, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarChat, 1),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarMonitoring, 2),
            label: "Monitoring",
          ),
          BottomNavigationBarItem(
            icon: _buildNavbar(Assets.iconsNavbarProfile, 3),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  SizedBox _buildNavbar(String img, int index) {
    return SizedBox(
      width: 24,
      height: 24,
      child: SvgPicture.asset(
        img,
        colorFilter: ColorFilter.mode(
          currentIndex == index ? context.primary : context.iconDisabled,
          .srcIn,
        ),
      ),
    );
  }
}
