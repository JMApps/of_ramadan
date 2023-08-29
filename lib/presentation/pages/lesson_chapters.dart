import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/application/styles/app_styles.dart';
import 'package:of_ramadan/application/themes/app_theme.dart';
import 'package:of_ramadan/data/arguments/lesson_arguments.dart';
import 'package:of_ramadan/data/model/lesson_model.dart';
import 'package:of_ramadan/presentation/items/lesson_item.dart';
import 'package:of_ramadan/presentation/items/lesson_item_tablet.dart';
import 'package:of_ramadan/presentation/widgets/search_lesson_delegate.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LessonChapters extends StatefulWidget {
  const LessonChapters({Key? key}) : super(key: key);

  @override
  State<LessonChapters> createState() => _LessonChaptersState();
}

class _LessonChaptersState extends State<LessonChapters> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchLessonDelegate(
                  hintText: AppStrings.searchQuestions,
                ),
              );
            },
            tooltip: AppStrings.searchQuestions,
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<LessonModel>>(
        future: mainAppState.getDatabaseQuery.getAllLessons(),
        builder: (BuildContext context, AsyncSnapshot<List<LessonModel>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CupertinoScrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ScreenTypeLayout.builder(
                          mobile: (BuildContext context) => LessonItem(
                            model: snapshot.data![index],
                            index: index,
                          ),
                          tablet: (BuildContext context) => LessonItemTablet(
                            model: snapshot.data![index],
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: mainAppState.getLastLesson > 0 ? true : false,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.mainBorderRadius,
                      side: BorderSide(
                        width: 1,
                        color: appColors.titleColor,
                      ),
                    ),
                    child: ScreenTypeLayout.builder(
                      mobile: (BuildContext context) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/answer_content',
                            arguments: LessonArguments(
                              lessonId: mainAppState.getLastLesson,
                            ),
                          );
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastLesson - 1} ${AppStrings.head}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      tablet: (BuildContext context) => InkWell(
                        onTap: () {
                          mainAppState.changeLessonId = mainAppState.getLastLesson;
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastLesson - 1} ${AppStrings.head}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: AppStyles.mainPadding,
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
