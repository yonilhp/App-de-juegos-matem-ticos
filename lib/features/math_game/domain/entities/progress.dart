/// Progreso del niño en una categoría - Entity pura de dominio
class CategoryProgress {
  final String categoryId;
  final int questionsAnswered;
  final int correctAnswers;
  final int wrongAnswers;
  final bool isCompleted;
  final DateTime? completedAt;

  const CategoryProgress({
    required this.categoryId,
    this.questionsAnswered = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.isCompleted = false,
    this.completedAt,
  });

  double get accuracy =>
      questionsAnswered > 0 ? (correctAnswers / questionsAnswered) * 100 : 0;

  CategoryProgress copyWith({
    String? categoryId,
    int? questionsAnswered,
    int? correctAnswers,
    int? wrongAnswers,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return CategoryProgress(
      categoryId: categoryId ?? this.categoryId,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryProgress &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}

/// Progreso general del niño - Entity pura de dominio
class ChildProgress {
  final String childId;
  final Map<String, CategoryProgress> categories;
  final int totalScore;
  final DateTime lastPlayedAt;

  const ChildProgress({
    required this.childId,
    required this.categories,
    this.totalScore = 0,
    required this.lastPlayedAt,
  });

  CategoryProgress? getProgress(String categoryId) => categories[categoryId];

  bool isCategoryCompleted(String categoryId) =>
      categories[categoryId]?.isCompleted ?? false;

  int get completedCategories =>
      categories.values.where((p) => p.isCompleted).length;

  ChildProgress copyWith({
    String? childId,
    Map<String, CategoryProgress>? categories,
    int? totalScore,
    DateTime? lastPlayedAt,
  }) {
    return ChildProgress(
      childId: childId ?? this.childId,
      categories: categories ?? this.categories,
      totalScore: totalScore ?? this.totalScore,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildProgress &&
          runtimeType == other.runtimeType &&
          childId == other.childId;

  @override
  int get hashCode => childId.hashCode;
}
