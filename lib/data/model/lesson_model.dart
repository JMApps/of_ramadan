class LessonModel {
  final int id;
  final String numberChapter;
  final String titleChapter;
  final String contentChapter;

  LessonModel({
    required this.id,
    required this.numberChapter,
    required this.titleChapter,
    required this.contentChapter,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'],
      numberChapter: map['number_chapter'],
      titleChapter: map['title_chapter'],
      contentChapter: map['content_chapter'],
    );
  }
}
