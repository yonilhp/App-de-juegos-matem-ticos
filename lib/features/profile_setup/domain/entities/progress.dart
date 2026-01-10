/// Progreso del niño en una categoría
class CategoryProgress {
  final String categoryId;
  final int questionsAnswered;
  final int correctAnswers;
  final int wrongAnswers;
  final bool isCompleted;
  final DateTime? completedAt;

  CategoryProgress({
    required this.categoryId,
    this.questionsAnswered = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.isCompleted = false,
    this.completedAt,
  });

  double get accuracy =>
      questionsAnswered > 0 ? (correctAnswers / questionsAnswered) * 100 : 0;

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'questionsAnswered': questionsAnswered,
    'correctAnswers': correctAnswers,
    'wrongAnswers': wrongAnswers,
    'isCompleted': isCompleted,
    'completedAt': completedAt?.toIso8601String(),
  };

  factory CategoryProgress.fromJson(Map<String, dynamic> json) =>
      CategoryProgress(
        categoryId: json['categoryId'] as String,
        questionsAnswered: json['questionsAnswered'] as int? ?? 0,
        correctAnswers: json['correctAnswers'] as int? ?? 0,
        wrongAnswers: json['wrongAnswers'] as int? ?? 0,
        isCompleted: json['isCompleted'] as bool? ?? false,
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'] as String)
            : null,
      );

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
}

/// Progreso general del niño
class ChildProgress {
  final String childId;
  final Map<String, CategoryProgress> categories;
  final int totalScore;
  final DateTime lastPlayedAt;

  ChildProgress({
    required this.childId,
    required this.categories,
    this.totalScore = 0,
    required this.lastPlayedAt,
  });

  /// Obtener el progreso de una categoría específica
  CategoryProgress? getProgress(String categoryId) => categories[categoryId];

  /// Verificar si una categoría está completada
  bool isCategoryCompleted(String categoryId) =>
      categories[categoryId]?.isCompleted ?? false;

  /// Obtener el número de categorías completadas
  int get completedCategories =>
      categories.values.where((p) => p.isCompleted).length;

  Map<String, dynamic> toJson() => {
    'childId': childId,
    'categories': categories.map((k, v) => MapEntry(k, v.toJson())),
    'totalScore': totalScore,
    'lastPlayedAt': lastPlayedAt.toIso8601String(),
  };

  factory ChildProgress.fromJson(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as Map<String, dynamic>? ?? {};
    return ChildProgress(
      childId: json['childId'] as String,
      categories: categoriesJson.map(
        (k, v) =>
            MapEntry(k, CategoryProgress.fromJson(v as Map<String, dynamic>)),
      ),
      totalScore: json['totalScore'] as int? ?? 0,
      lastPlayedAt: DateTime.parse(json['lastPlayedAt'] as String),
    );
  }

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
}
