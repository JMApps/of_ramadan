import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:of_ramadan/application/strings/app_constraints.dart';
import 'package:of_ramadan/data/database_query.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  int _lessonId = 1;

  int get getQuestionId => _lessonId;

  int _lastLesson = -1;

  int get getLastLesson => _lastLesson;

  set saveLastLesson(int lessonId) {
    _lastLesson = lessonId;
    _contentSettingsBox.put(AppConstraints.keyLastHead, lessonId);
    notifyListeners();
  }

  set changeLessonId(int lessonId) {
    _lessonId = lessonId;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> addRemoveBookmark(int favoriteState, int lessonId) async {
    _databaseQuery.addRemoveFavorite(favoriteState, lessonId);
    notifyListeners();
  }

  MainAppState() {
    _lastLesson = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: -1);
  }
}
