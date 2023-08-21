import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/styles/app_styles.dart';
import 'package:of_ramadan/application/themes/app_theme.dart';
import 'package:of_ramadan/data/arguments/lesson_arguments.dart';
import 'package:of_ramadan/data/model/lesson_model.dart';
import 'package:provider/provider.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({
    super.key,
    required this.model,
    required this.index,
  });

  final LessonModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: AppStyles.mainShape,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/answer_content',
            arguments: LessonArguments(
              lessonId: model.id,
            ),
          );
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
            context.read<MainAppState>().addRemoveBookmark(model.favoriteState == 0 ? 1 : 0, model.id);
          },
          icon: Icon(
            model.favoriteState == 1
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.titleColor,
          ),
        ),
      ),
    );
  }
}
