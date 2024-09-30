import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_trial/common/splash_screen.dart';
import 'package:go_router_trial/router/provider/go_router_provider.dart';

void main() => runApp(
      const ProviderScope(
        child: GoRouterTrial(),
      ),
    );

class GoRouterTrial extends ConsumerWidget {
  const GoRouterTrial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouteConfig = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouteConfig,
      // routeInformationParser: goRouteConfig.routeInformationParser,
      // routeInformationProvider: goRouteConfig.routeInformationProvider,
      // routerDelegate: goRouteConfig.routerDelegate,
      // backButtonDispatcher: goRouteConfig.backButtonDispatcher,
    );
  }
}
