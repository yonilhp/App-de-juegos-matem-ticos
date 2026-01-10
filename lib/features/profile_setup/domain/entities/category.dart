/// Estado de una categoría
enum CategoryStatus {
  locked, // 🔒 Bloqueada
  active, // 🎮 Activa (disponible para jugar)
  completed, // ✅ Completada
}

/// Categoría de aprendizaje
class Category {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int order; // Orden de desbloqueo (1, 2, 3, 4...)
  final int totalQuestions; // Total de preguntas para completar
  final String color; // Color hex para la UI

  Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.order,
    this.totalQuestions = 10,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'emoji': emoji,
    'description': description,
    'order': order,
    'totalQuestions': totalQuestions,
    'color': color,
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as String,
    name: json['name'] as String,
    emoji: json['emoji'] as String,
    description: json['description'] as String,
    order: json['order'] as int,
    totalQuestions: json['totalQuestions'] as int? ?? 10,
    color: json['color'] as String,
  );
}

/// Categorías predefinidas de la app
class AppCategories {
  static final List<Category> all = [
    Category(
      id: 'animals',
      name: 'Animales',
      emoji: '🦁',
      description: '¡Aprende sobre los animales!',
      order: 1,
      color: '#FF9800',
    ),
    Category(
      id: 'fruits',
      name: 'Frutas',
      emoji: '🍎',
      description: '¡Descubre las frutas!',
      order: 2,
      color: '#E91E63',
    ),
    Category(
      id: 'colors',
      name: 'Colores',
      emoji: '🎨',
      description: '¡Aprende los colores!',
      order: 3,
      color: '#9C27B0',
    ),
    Category(
      id: 'shapes',
      name: 'Figuras',
      emoji: '🔺',
      description: '¡Conoce las figuras!',
      order: 4,
      color: '#2196F3',
    ),
  ];

  static Category? getById(String id) {
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static Category? getByOrder(int order) {
    try {
      return all.firstWhere((c) => c.order == order);
    } catch (_) {
      return null;
    }
  }
}
