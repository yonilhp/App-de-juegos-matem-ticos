import 'package:num_num/features/math_game/domain/entities/progress.dart';

/// Model para serialización de CategoryProgress
class CategoryProgressModel {
  final String categoryId;
  final int questionsAnswered;
  final int correctAnswers;
  final int wrongAnswers;
  final bool isCompleted;
  final DateTime? completedAt;

  const CategoryProgressModel({
    required this.categoryId,
    this.questionsAnswered = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.isCompleted = false,
    this.completedAt,
  });

  /// Convertir desde JSON (API/Firebase)
  factory CategoryProgressModel.fromJson(Map<String, dynamic> json) {
    return CategoryProgressModel(
      categoryId: json['categoryId'] as String,
      questionsAnswered: json['questionsAnswered'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      wrongAnswers: json['wrongAnswers'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  /// Convertir a JSON para guardar
  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'questionsAnswered': questionsAnswered,
    'correctAnswers': correctAnswers,
    'wrongAnswers': wrongAnswers,
    'isCompleted': isCompleted,
    'completedAt': completedAt?.toIso8601String(),
  };

  /// Crear Model desde Entity
  factory CategoryProgressModel.fromEntity(CategoryProgress entity) {
    return CategoryProgressModel(
      categoryId: entity.categoryId,
      questionsAnswered: entity.questionsAnswered,
      correctAnswers: entity.correctAnswers,
      wrongAnswers: entity.wrongAnswers,
      isCompleted: entity.isCompleted,
      completedAt: entity.completedAt,
    );
  }

  /// Convertir a Entity
  CategoryProgress toEntity() {
    return CategoryProgress(
      categoryId: categoryId,
      questionsAnswered: questionsAnswered,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      isCompleted: isCompleted,
      completedAt: completedAt,
    );
  }
}

/// Model para serialización de ChildProgress
class ChildProgressModel {
  final String childId;
  final Map<String, CategoryProgressModel> categories;
  final int totalScore;
  final DateTime lastPlayedAt;

  const ChildProgressModel({
    required this.childId,
    required this.categories,
    this.totalScore = 0,
    required this.lastPlayedAt,
  });

  /// Convertir desde JSON (API/Firebase)
  factory ChildProgressModel.fromJson(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as Map<String, dynamic>? ?? {};
    return ChildProgressModel(
      childId: json['childId'] as String,
      categories: categoriesJson.map(
        (k, v) => MapEntry(
          k,
          CategoryProgressModel.fromJson(v as Map<String, dynamic>),
        ),
      ),
      totalScore: json['totalScore'] as int? ?? 0,
      lastPlayedAt: DateTime.parse(json['lastPlayedAt'] as String),
    );
  }

  /// Convertir a JSON para guardar
  Map<String, dynamic> toJson() => {
    'childId': childId,
    'categories': categories.map((k, v) => MapEntry(k, v.toJson())),
    'totalScore': totalScore,
    'lastPlayedAt': lastPlayedAt.toIso8601String(),
  };

  /// Crear Model desde Entity
  factory ChildProgressModel.fromEntity(ChildProgress entity) {
    return ChildProgressModel(
      childId: entity.childId,
      categories: entity.categories.map(
        (k, v) => MapEntry(k, CategoryProgressModel.fromEntity(v)),
      ),
      totalScore: entity.totalScore,
      lastPlayedAt: entity.lastPlayedAt,
    );
  }

  /// Convertir a Entity
  ChildProgress toEntity() {
    return ChildProgress(
      childId: childId,
      categories: categories.map((k, v) => MapEntry(k, v.toEntity())),
      totalScore: totalScore,
      lastPlayedAt: lastPlayedAt,
    );
  }
}
