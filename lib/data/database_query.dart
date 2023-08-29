import 'package:of_ramadan/data/database_helper.dart';
import 'package:of_ramadan/data/model/lesson_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<LessonModel>> getAllLessons() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_lessons_ramadan');
    List<LessonModel>? allLessons = res.isNotEmpty ? res.map((c) => LessonModel.fromMap(c)).toList() : null;
    return allLessons!;
  }

  Future<List<LessonModel>> getFavoriteLessons({required List<int> favorites}) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_lessons_ramadan', where: 'id IN (${favorites.map((id) => '?').join(', ')})', whereArgs: favorites);
    List<LessonModel>? favoriteLessons = res.isNotEmpty ? res.map((c) => LessonModel.fromMap(c)).toList() : null;
    return favoriteLessons!;
  }

  Future<List<LessonModel>> getLessonContent(int lessonId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_lessons_ramadan', where: 'id == $lessonId');
    List<LessonModel>? chapterContent = res.isNotEmpty ? res.map((c) => LessonModel.fromMap(c)).toList() : null;
    return chapterContent!;
  }
}
