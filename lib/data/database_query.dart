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

  Future<List<LessonModel>> getFavoriteLessons() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_lessons_ramadan', where: 'favorite_state == 1');
    List<LessonModel>? favoriteLessons = res.isNotEmpty ? res.map((c) => LessonModel.fromMap(c)).toList() : null;
    return favoriteLessons!;
  }

  Future<List<LessonModel>> getLessonContent(int lessonId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_lessons_ramadan', where: 'id == $lessonId');
    List<LessonModel>? chapterContent = res.isNotEmpty ? res.map((c) => LessonModel.fromMap(c)).toList() : null;
    return chapterContent!;
  }

  Future<void> addRemoveFavorite(int state, int id) async {
    final Database dbClient = await _databaseHelper.db;
    await dbClient.rawQuery('UPDATE Table_of_lessons_ramadan SET favorite_state = $state WHERE id == $id');
  }
}
