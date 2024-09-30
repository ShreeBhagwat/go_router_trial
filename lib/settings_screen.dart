import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_trial/common/widgets/navigator_button.dart';
import 'package:go_router_trial/router/route_names.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: NavigatorButton(
            buttonTitle: 'Buttton',
            onPressed: () {
              context.pushNamed(RouteNames.settingsAbout);
            }),
      ),
    );
  }
}
