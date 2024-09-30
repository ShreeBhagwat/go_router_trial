import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_trial/common/error_screen.dart';
import 'package:go_router_trial/common/widgets/bottom_navbar_screen.dart';
import 'package:go_router_trial/common/splash_screen.dart';
import 'package:go_router_trial/edit_profile.dart';
import 'package:go_router_trial/home_screen.dart';
import 'package:go_router_trial/profile_screen.dart';
import 'package:go_router_trial/router/route_names.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splashRoute.path(),
    // redirect: (context, state) {

    // },
    routes: [
      GoRoute(
          name: RouteNames.splashRoute,
          path: RouteNames.splashRoute.path(),
          builder: (context, state) {
            return const SplashScreen();
          },
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              path: RouteNames.initialRoute,
              name: RouteNames.initialRoute,
              builder: (context, state) => const InitialScreen(),
            ),
            GoRoute(
              name: RouteNames.homeRoute,
              path: RouteNames.homeRoute,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
                name: RouteNames.profileRoute,
                path: RouteNames.profileRoute,
                builder: (context, state) => const ProfileScreen()),
            GoRoute(
              name: RouteNames.editProfile,
              path: '${RouteNames.editProfile}',
              builder: (context, state) {
                // final userName = state.pathParameters['userName'];
                return EditProfileScreen(userName: 'userName');
              },
            ),
          ]),
    ],
    errorBuilder: (context, state) {
      return const ErrorScreen();
    },
  );
});
