import 'package:flutter/material.dart';
import 'package:of_ramadan/data/arguments/lesson_arguments.dart';
import 'package:of_ramadan/presentation/pages/lesson_content_page.dart';
import 'package:of_ramadan/presentation/pages/settings_page.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/answer_content':
        final LessonArguments lessonArguments = routeSettings.arguments as LessonArguments;
        return MaterialPageRoute(
          builder: (_) => LessonContentPage(
            lessonId: lessonArguments.lessonId,
          ),
        );
      case '/app_settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
