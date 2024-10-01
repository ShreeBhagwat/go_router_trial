import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_trial/common/widgets/navigator_button.dart';
import 'package:go_router_trial/router/provider/async_redirection.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StreamAuth info = StreamAuthScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: NavigatorButton(
          buttonTitle: 'Logout',
          onPressed: () => info.signOut(),
        ),
      ),
    );
  }
}
