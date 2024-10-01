import 'package:flutter/material.dart';

class SettingsAboutScreen extends StatelessWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Settings About Screen'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Settings About Screen'),
        ),
      ),
    );
  }
}
