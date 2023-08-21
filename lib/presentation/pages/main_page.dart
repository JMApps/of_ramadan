import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/presentation/pages/lesson_chapters.dart';
import 'package:of_ramadan/presentation/pages/lesson_favorites.dart';
import 'package:of_ramadan/presentation/pages/settings_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _listWidgets = [
    const LessonChapters(),
    const LessonFavorites(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = context.watch<MainAppState>();
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeInToLinear,
        switchOutCurve: Curves.easeInToLinear,
        child: _listWidgets[mainAppState.getSelectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.heads,
            icon: Icon(CupertinoIcons.collections),
          ),
          BottomNavigationBarItem(
            label: AppStrings.bookmarks,
            icon: Icon(CupertinoIcons.bookmark),
          ),
          BottomNavigationBarItem(
            label: AppStrings.settings,
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        currentIndex: mainAppState.getSelectedIndex,
        onTap: context.read<MainAppState>().changeSelectedIndex,
      ),
    );
  }
}
