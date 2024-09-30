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
import 'package:go_router_trial/search_screen.dart';
import 'package:go_router_trial/settings_about_screen.dart';
import 'package:go_router_trial/settings_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'Shell A');
final shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'Shell B');

final shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'Shell C');
final shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'Shell D');
final shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'Shell E');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.splashRoute.path(),
    // redirect: (context, state) {

    // },
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: RouteNames.splashRoute,
        path: RouteNames.splashRoute.path(),
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => navigationShell,
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                // parentNavigatorKey: shellNavigatorAKey,
                path: RouteNames.initialRoute.path(),
                name: RouteNames.initialRoute,
                builder: (context, state) => const InitialScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                // parentNavigatorKey: shellNavigatorBKey,
                name: RouteNames.homeRoute,
                path: RouteNames.homeRoute.path(),
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  // parentNavigatorKey: shellNavigatorCKey,
                  name: RouteNames.profileRoute,
                  path: RouteNames.profileRoute.path(),
                  routes: [
                    GoRoute(
                      // parentNavigatorKey: rootNavigatorKey,
                      name: RouteNames.editProfile,
                      path: '${RouteNames.editProfile}/:userName',
                      builder: (context, state) {
                        final userName = state.pathParameters['userName'];
                        return EditProfileScreen(userName: userName!);
                      },
                    ),
                  ],
                  builder: (context, state) => const ProfileScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  // parentNavigatorKey: shellNavigatorDKey,
                  path: RouteNames.searchRoute.path(),
                  name: RouteNames.searchRoute,
                  builder: (context, state) {
                    return const SearchScreen();
                  }),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorEKey,
            routes: [
              GoRoute(
                // parentNavigatorKey: shellNavigatorEKey,
                path: RouteNames.settingsRoute.path(),
                name: RouteNames.settingsRoute,
                builder: (context, state) {
                  return const SettingsScreen();
                },
                routes: [
                  GoRoute(
                      // parentNavigatorKey: shellNavigatorEKey,
                      path: RouteNames.settingsAbout,
                      name: RouteNames.settingsAbout,
                      builder: (context, state) {
                        return const SettingsAboutScreen();
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return const ErrorScreen();
    },
  );
});
