/// Estado de una categoría
enum CategoryStatus { locked, active, completed }

/// Categoría de aprendizaje - Entity pura de dominio
class Category {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int order;
  final int totalQuestions;
  final String color;

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.order,
    this.totalQuestions = 10,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Categorías predefinidas de la app (datos locales de prueba)
class AppCategories {
  static const List<Category> all = [
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
