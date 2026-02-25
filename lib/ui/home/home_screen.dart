/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/ui/home/chat/chat_screen.dart';
import 'package:touristapp/ui/home/monitoring/monitoring_screen.dart';
import 'package:touristapp/ui/home/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _pages = [
    HomeScreen(),
    ChatScreen(),
    MonitoringScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page ${currentIndex + 1}"),),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(bottom: 16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // Background Nav Bar
            Container(
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, "Home", 0),
                  _buildNavItem(Icons.chat_bubble_outline, "Chat", 1),
                  const SizedBox(width: 50), // space for center button
                  _buildNavItem(Icons.show_chart, "History", 2),
                  _buildNavItem(Icons.person_outline, "Profile", 3),
                ],
              ),
            ),

            // Center Floating QR Button
            Positioned(
              top: -20,
              child: GestureDetector(
                onTap: () => setState(() => currentIndex = 4),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C4DFF), Color(0xFF4B2EFF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: const Icon(Icons.qr_code_2,
                      color: Colors.white, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFF6C4DFF) : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Color(0xFF6C4DFF) : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
