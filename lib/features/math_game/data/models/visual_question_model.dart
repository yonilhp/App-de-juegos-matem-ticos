import 'package:num_num/features/math_game/domain/entities/visual_question.dart';

/// Model para serialización de VisualQuestion
/// Se usa para comunicación con API/Firebase
class VisualQuestionModel {
  final String id;
  final String categoryId;
  final String imageUrl;
  final String correctAnswer;
  final List<String> options;
  final String? audioUrl;

  const VisualQuestionModel({
    required this.id,
    required this.categoryId,
    required this.imageUrl,
    required this.correctAnswer,
    required this.options,
    this.audioUrl,
  });

  /// Convertir desde JSON (API/Firebase)
  factory VisualQuestionModel.fromJson(Map<String, dynamic> json) {
    return VisualQuestionModel(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      correctAnswer: json['correctAnswer'] as String,
      options: List<String>.from(json['options'] as List),
      audioUrl: json['audioUrl'] as String?,
    );
  }

  /// Convertir a JSON para guardar
  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'imageUrl': imageUrl,
    'correctAnswer': correctAnswer,
    'options': options,
    'audioUrl': audioUrl,
  };

  /// Crear Model desde Entity
  factory VisualQuestionModel.fromEntity(VisualQuestion entity) {
    return VisualQuestionModel(
      id: entity.id,
      categoryId: entity.categoryId,
      imageUrl: entity.imageUrl,
      correctAnswer: entity.correctAnswer,
      options: entity.options,
      audioUrl: entity.audioUrl,
    );
  }

  /// Convertir a Entity para usar en la app
  VisualQuestion toEntity() {
    return VisualQuestion(
      id: id,
      categoryId: categoryId,
      imageUrl: imageUrl,
      correctAnswer: correctAnswer,
      options: options,
      audioUrl: audioUrl,
    );
  }
}
