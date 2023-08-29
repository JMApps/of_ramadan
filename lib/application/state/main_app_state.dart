import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:of_ramadan/application/strings/app_constraints.dart';
import 'package:of_ramadan/data/database_query.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  final _favoritesBox = Hive.box(AppConstraints.keyFavoritesList);

  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  int _lessonId = 1;

  int get getQuestionId => _lessonId;

  int _lastLesson = -1;

  int get getLastLesson => _lastLesson;

  List<int> _favoriteLessons = [];

  List<int> get getFavoriteLessons => _favoriteLessons;

  toggleFavorite(int id) {
    final exist = _favoriteLessons.contains(id);
    if (exist) {
      _favoriteLessons.remove(id);
    } else {
      _favoriteLessons.add(id);
    }
    _favoritesBox.put(AppConstraints.keyFavoritesList, _favoriteLessons);
    notifyListeners();
  }

  bool supplicationIsFavorite(int id) {
    final exist = _favoriteLessons.contains(id);
    return exist;
  }

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

  MainAppState() {
    _lastLesson = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: -1);
    _favoriteLessons = _favoritesBox.get(AppConstraints.keyFavoritesList, defaultValue: <int>[]);
  }
}
