import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/presentation/pages/lesson_chapters.dart';
import 'package:of_ramadan/presentation/pages/lesson_content_page.dart';
import 'package:of_ramadan/presentation/pages/lesson_favorites.dart';
import 'package:provider/provider.dart';

class TabletPage extends StatefulWidget {
  const TabletPage({super.key});

  @override
  State<TabletPage> createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {
  final List<Widget> _listWidgets = [
    const LessonChapters(),
    const LessonFavorites(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Material(
      child: Row(
        children: [
          Expanded(
            child: Scaffold(
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
                ],
                currentIndex: mainAppState.getSelectedIndex,
                onTap: context.read<MainAppState>().changeSelectedIndex,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: LessonContentPage(
              lessonId: mainAppState.getQuestionId,
            ),
          ),
        ],
      ),
    );
  }
}
