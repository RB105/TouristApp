/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/ui/auth/view/auth_screen.dart';
import 'package:touristapp/ui/home/chat/chat_screen.dart';
import 'package:touristapp/ui/home/home_screen.dart';
import 'package:touristapp/ui/home/main/ui/main_screen.dart';
import 'package:touristapp/ui/home/main/ui/payments_screen.dart';
import 'package:touristapp/ui/home/monitoring/monitoring_screen.dart';
import 'package:touristapp/ui/home/profile/profile_screen.dart';
import 'package:touristapp/ui/splash/on_boarding_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// CustomTransitionPage<T> _buildBottomSheetPage<T>({
//   required Widget child,
//   final int? transitionDuration,
//   final int? reverseTransitionDuration,
// }) {
//   return CustomTransitionPage<T>(
//     transitionDuration: Duration(milliseconds: transitionDuration ?? 300),
//     reverseTransitionDuration: Duration(
//       milliseconds: reverseTransitionDuration ?? 250,
//     ),
//     opaque: false,
//     barrierColor: Colors.black.withOpacity(0.5),
//     child: child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final tween = Tween(
//         begin: const Offset(0, 1),
//         end: Offset.zero,
//       ).chain(CurveTween(curve: Curves.easeOutCubic));
//
//       return SlideTransition(position: animation.drive(tween), child: child);
//     },
//   );
// }

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final firstLaunch = GetStorage().read<bool?>('first_launch');
        if (firstLaunch ?? true) {
          debugPrint(firstLaunch.toString());
          return '/onboarding';
        }
        final access = GetStorage().read<String?>('access_token');
        if (access == null) {
          return '/auth';
        }

        return '/main';
      },
    ),

    GoRoute(
      path: '/auth',
      builder: (context, state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) {
        return const OnBoardingScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: navigatorKey,
      builder: (context, state, navigationShell) =>
          HomeScreen(shell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/main',
              builder: (context, state) => const MainScreen(),
              routes: [
                GoRoute(
                  path: 'payments',
                  builder: (context, state) => PaymentsScreen(),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/monitoring',
              builder: (context, state) => const MonitoringScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
