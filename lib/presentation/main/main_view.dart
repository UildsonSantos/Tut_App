import 'package:flutter/material.dart';
import 'package:tut_app/presentation/main/home_page.dart';
import 'package:tut_app/presentation/main/notifications_page.dart';
import 'package:tut_app/presentation/main/search_page.dart';
import 'package:tut_app/presentation/main/settings_page.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];
  final _title = AppStrings.home;
  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[_currentIndex],
    );
  }
}
