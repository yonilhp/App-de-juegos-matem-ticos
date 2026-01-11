import 'package:num_num/features/math_game/domain/entities/category.dart';

/// Model para serialización de Category
/// Se usa para comunicación con API/Firebase
class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int order;
  final int totalQuestions;
  final String color;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.order,
    this.totalQuestions = 10,
    required this.color,
  });

  /// Convertir desde JSON (API/Firebase)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      totalQuestions: json['totalQuestions'] as int? ?? 10,
      color: json['color'] as String,
    );
  }

  /// Convertir a JSON para guardar
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'emoji': emoji,
    'description': description,
    'order': order,
    'totalQuestions': totalQuestions,
    'color': color,
  };

  /// Crear Model desde Entity
  factory CategoryModel.fromEntity(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      emoji: entity.emoji,
      description: entity.description,
      order: entity.order,
      totalQuestions: entity.totalQuestions,
      color: entity.color,
    );
  }

  /// Convertir a Entity para usar en la app
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      emoji: emoji,
      description: description,
      order: order,
      totalQuestions: totalQuestions,
      color: color,
    );
  }
}
