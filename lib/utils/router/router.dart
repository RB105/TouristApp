/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/utils/router/app_router.dart';

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
  routes: $appRoutes,
);
