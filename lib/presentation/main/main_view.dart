import 'package:advanced_flutter/presentation/main/pages/home_page.dart';
import 'package:advanced_flutter/presentation/main/pages/notifications_page.dart';
import 'package:advanced_flutter/presentation/main/pages/search_v.dart';
import 'package:advanced_flutter/presentation/main/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];

  String _pageTitle = "Home";
  int _currentPageIndex = 0;

  AppPreferences ap = gi<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle,
            style: Theme.of(context).textTheme.bodyMedium), // titleSmall
      ),
      body: pages[_currentPageIndex],
    );
  }
}
