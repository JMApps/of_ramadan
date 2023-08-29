import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/application/styles/app_styles.dart';
import 'package:of_ramadan/application/themes/app_theme.dart';
import 'package:of_ramadan/data/model/lesson_model.dart';
import 'package:provider/provider.dart';

class LessonItemTablet extends StatelessWidget {
  const LessonItemTablet({
    super.key,
    required this.model,
    required this.index,
  });

  final LessonModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final MainAppState readMainState = context.read<MainAppState>();
    final bool isBookmark = readMainState.supplicationIsFavorite(model.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: AppStyles.mainShape,
      child: ListTile(
        onTap: () {
          readMainState.saveLastLesson = model.id;
          readMainState.changeLessonId = model.id;
        },
        shape: AppStyles.mainShape,
        contentPadding: AppStyles.mainPaddingMini,
        visualDensity: const VisualDensity(horizontal: -4),
        title: Text(
          model.numberChapter,
          style: TextStyle(
            color: appColors.titleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        subtitle: Text(
          model.titleChapter,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            readMainState.toggleFavorite(model.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: appColors.titleColor,
                duration: const Duration(milliseconds: 350),
                content: Text(
                  isBookmark ? AppStrings.removed : AppStrings.added,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          icon: Icon(
            isBookmark
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.titleColor,
          ),
        ),
      ),
    );
  }
}
