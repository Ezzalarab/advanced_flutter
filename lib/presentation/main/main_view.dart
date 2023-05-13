import 'package:flutter/material.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  AppPreferences ap = gi<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ap.setIsLogOut();
          },
          child: const Text("reset login"),
        ),
      ),
    );
  }
}
