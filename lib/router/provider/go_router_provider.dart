import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_trial/auth/login_screen.dart';
import 'package:go_router_trial/common/error_screen.dart';
import 'package:go_router_trial/common/widgets/bottom_navbar_screen.dart';
import 'package:go_router_trial/common/splash_screen.dart';
import 'package:go_router_trial/edit_profile.dart';
import 'package:go_router_trial/home_screen.dart';
import 'package:go_router_trial/profile_screen.dart';
import 'package:go_router_trial/router/provider/async_redirection.dart';
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
    // redirect to the login page if the user is not logged in
    redirect: (context, state) async {
      // Using `of` method creates a dependency of StreamAuthScope. It will
      // cause go_router to reparse current route if StreamAuth has new sign-in
      // information.
      final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
      final bool loggingIn =
          state.matchedLocation == RouteNames.loginRoute.path();

      final bool isSplashRoute =
          state.matchedLocation == RouteNames.splashRoute.path();

      if (!loggedIn) {
        if (isSplashRoute) return null;
        return RouteNames.loginRoute.path();
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return RouteNames.homeRoute.path();
      }

      // no need to redirect at all
      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: RouteNames.splashRoute,
        path: RouteNames.splashRoute.path(),
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: RouteNames.loginRoute,
        path: RouteNames.loginRoute.path(),
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        ///  When creating a StatefulShellRoute, a
        /// builder function must be provided. This function is responsible
        /// for building the actual container for the Widgets representing
        /// the branch Navigators.
        builder: (context, state, navigationShell) {
          return InitialScreen(navigationShell: navigationShell);
        },
        branches: [
          //It is not necessary to provide a navigatorKey if it isn't also
          //needed elsewhere. If not provided, a default key will be used.
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.homeRoute,
                path: RouteNames.homeRoute.path(),
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.profileRoute,
                path: RouteNames.profileRoute.path(),
                routes: [
                  GoRoute(
                    name: RouteNames.editProfile,
                    path: '${RouteNames.editProfile}/:userName',
                    builder: (context, state) {
                      final userName = state.pathParameters['userName'];
                      return EditProfileScreen(userName: userName!);
                    },
                  ),
                ],
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.searchRoute.path(),
                name: RouteNames.searchRoute,
                builder: (context, state) {
                  return const SearchScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settingsRoute.path(),
                name: RouteNames.settingsRoute,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const SettingsScreen(),
                ),
                routes: [],
              ),
              GoRoute(
                path: RouteNames.settingsAboutRoute.path(),
                name: RouteNames.settingsAboutRoute,
                builder: (context, state) {
                  return const SettingsAboutScreen();
                },
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
