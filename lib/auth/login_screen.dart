import 'package:flutter/material.dart';
import 'package:go_router_trial/router/provider/async_redirection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool loggingIn = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Login Screen')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (loggingIn) CircularProgressIndicator(value: controller.value),
              if (!loggingIn)
                ElevatedButton(
                  onPressed: () {
                    StreamAuthScope.of(context).signIn('test-user');
                    setState(() {
                      loggingIn = true;
                    });
                  },
                  child: const Text('Login'),
                ),
            ],
          ),
        ),
      );
}
