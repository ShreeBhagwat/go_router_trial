import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_trial/router/provider/async_redirection.dart';
import 'package:go_router_trial/router/provider/go_router_provider.dart';

void main() => runApp(
      ProviderScope(
        child: StreamAuthScope(
          child: const GoRouterTrial(),
        ),
      ),
    );

class GoRouterTrial extends ConsumerWidget {
  const GoRouterTrial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouteConfig = ref.watch(goRouterProvider);
    return MaterialApp.router(routerConfig: goRouteConfig);
  }
}
