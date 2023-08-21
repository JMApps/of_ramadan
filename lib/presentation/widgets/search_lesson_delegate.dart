import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/application/styles/app_styles.dart';
import 'package:of_ramadan/data/model/lesson_model.dart';
import 'package:of_ramadan/presentation/items/lesson_item.dart';
import 'package:provider/provider.dart';

class SearchLessonDelegate extends SearchDelegate {
  List<LessonModel> _lessons = [];
  List<LessonModel> _recentLessons = [];

  SearchLessonDelegate({
    required String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              onPressed: () {
                query = '';
              },
              splashRadius: 15,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: transitionAnimation,
              ),
            )
          : const SizedBox(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      splashRadius: 20,
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchFuture(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchFuture(context);
  }

  Widget _searchFuture(BuildContext context) {
    return FutureBuilder<List>(
      future: context.watch<MainAppState>().getDatabaseQuery.getAllLessons(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _lessons = snapshot.data;
          _recentLessons = query.isEmpty
              ? _lessons
              : _lessons.where((element) =>
                      element.id.toString().contains(query) ||
                      element.numberChapter.toLowerCase().contains(query.toLowerCase()) ||
                      element.titleChapter.toLowerCase().contains(query.toLowerCase())).toList();
          return _recentLessons.isEmpty
              ? const Padding(
                  padding: AppStyles.mainPadding,
                  child: Center(
                    child: Text(
                      AppStrings.searchQueryIsEmpty,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : CupertinoScrollbar(
                  child: ListView.builder(
                    padding: AppStyles.mainPaddingMini,
                    itemCount: _recentLessons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LessonItem(
                        model: _recentLessons[index],
                        index: index,
                      );
                    },
                  ),
                );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
