import 'package:flutter/material.dart';
import 'package:of_ramadan/data/database_query.dart';

class MainAppState extends ChangeNotifier {
  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  int _lessonId = 1;

  int get getQuestionId => _lessonId;

  set changeQuestionId(int questionId) {
    _lessonId = questionId;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> addRemoveBookmark(int favoriteState, int questionId) async {
    _databaseQuery.addRemoveFavorite(favoriteState, questionId);
    notifyListeners();
  }
}
