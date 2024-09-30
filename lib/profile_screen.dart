import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_trial/common/splash_screen.dart';
import 'package:go_router_trial/common/widgets/navigator_button.dart';
import 'package:go_router_trial/router/route_names.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
            NavigatorButton(
                buttonTitle: 'Edit profile',
                onPressed: () {
                  context.pushNamed(RouteNames.editProfile,
                      pathParameters: {'userName': 'Shree'});
                }),
          ],
        ),
      ),
    );
  }
}
