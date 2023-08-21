class LessonModel {
  final int id;
  final String numberChapter;
  final String titleChapter;
  final String contentChapter;
  final int favoriteState;

  LessonModel({
    required this.id,
    required this.numberChapter,
    required this.titleChapter,
    required this.contentChapter,
    required this.favoriteState,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'],
      numberChapter: map['number_chapter'],
      titleChapter: map['title_chapter'],
      contentChapter: map['content_chapter'],
      favoriteState: map['favorite_state'],
    );
  }
}
