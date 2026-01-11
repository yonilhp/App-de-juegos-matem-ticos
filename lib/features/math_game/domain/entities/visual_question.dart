/// Pregunta visual del juego - Entity pura de dominio
class VisualQuestion {
  final String id;
  final String categoryId;
  final String imageUrl;
  final String correctAnswer;
  final List<String> options;
  final String? audioUrl;

  const VisualQuestion({
    required this.id,
    required this.categoryId,
    required this.imageUrl,
    required this.correctAnswer,
    required this.options,
    this.audioUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisualQuestion &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Preguntas de prueba (después vendrán del backend)
class MockQuestions {
  static List<VisualQuestion> getByCategory(String categoryId) {
    switch (categoryId) {
      case 'animals':
        return _animalQuestions;
      case 'fruits':
        return _fruitQuestions;
      case 'colors':
        return _colorQuestions;
      case 'shapes':
        return _shapeQuestions;
      default:
        return [];
    }
  }

  static final List<VisualQuestion> _animalQuestions = [
    VisualQuestion(
      id: 'a1',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/dog.png',
      correctAnswer: 'Perro',
      options: ['Perro', 'Gato', 'León'],
    ),
    VisualQuestion(
      id: 'a2',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/cat.png',
      correctAnswer: 'Gato',
      options: ['Perro', 'Gato', 'Pájaro'],
    ),
    VisualQuestion(
      id: 'a3',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/lion.png',
      correctAnswer: 'León',
      options: ['Tigre', 'León', 'Oso'],
    ),
    VisualQuestion(
      id: 'a4',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/elephant.png',
      correctAnswer: 'Elefante',
      options: ['Elefante', 'Jirafa', 'Hipopótamo'],
    ),
    VisualQuestion(
      id: 'a5',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/bird.png',
      correctAnswer: 'Pájaro',
      options: ['Mariposa', 'Pájaro', 'Abeja'],
    ),
    VisualQuestion(
      id: 'a6',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/fish.png',
      correctAnswer: 'Pez',
      options: ['Delfín', 'Ballena', 'Pez'],
    ),
    VisualQuestion(
      id: 'a7',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/rabbit.png',
      correctAnswer: 'Conejo',
      options: ['Conejo', 'Ratón', 'Ardilla'],
    ),
    VisualQuestion(
      id: 'a8',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/bear.png',
      correctAnswer: 'Oso',
      options: ['Lobo', 'Oso', 'Zorro'],
    ),
    VisualQuestion(
      id: 'a9',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/monkey.png',
      correctAnswer: 'Mono',
      options: ['Gorila', 'Chimpancé', 'Mono'],
    ),
    VisualQuestion(
      id: 'a10',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/turtle.png',
      correctAnswer: 'Tortuga',
      options: ['Tortuga', 'Cocodrilo', 'Lagarto'],
    ),
  ];

  static final List<VisualQuestion> _fruitQuestions = [
    VisualQuestion(
      id: 'f1',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/apple.png',
      correctAnswer: 'Manzana',
      options: ['Manzana', 'Pera', 'Durazno'],
    ),
    VisualQuestion(
      id: 'f2',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/banana.png',
      correctAnswer: 'Plátano',
      options: ['Plátano', 'Mango', 'Papaya'],
    ),
    VisualQuestion(
      id: 'f3',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/orange.png',
      correctAnswer: 'Naranja',
      options: ['Limón', 'Naranja', 'Mandarina'],
    ),
    VisualQuestion(
      id: 'f4',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/strawberry.png',
      correctAnswer: 'Fresa',
      options: ['Cereza', 'Fresa', 'Frambuesa'],
    ),
    VisualQuestion(
      id: 'f5',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/grape.png',
      correctAnswer: 'Uva',
      options: ['Uva', 'Ciruela', 'Mora'],
    ),
    VisualQuestion(
      id: 'f6',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/watermelon.png',
      correctAnswer: 'Sandía',
      options: ['Melón', 'Sandía', 'Piña'],
    ),
    VisualQuestion(
      id: 'f7',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/pear.png',
      correctAnswer: 'Pera',
      options: ['Manzana', 'Pera', 'Kiwi'],
    ),
    VisualQuestion(
      id: 'f8',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/cherry.png',
      correctAnswer: 'Cereza',
      options: ['Cereza', 'Tomate', 'Fresa'],
    ),
    VisualQuestion(
      id: 'f9',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/pineapple.png',
      correctAnswer: 'Piña',
      options: ['Coco', 'Piña', 'Mango'],
    ),
    VisualQuestion(
      id: 'f10',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/peach.png',
      correctAnswer: 'Durazno',
      options: ['Durazno', 'Albaricoque', 'Nectarina'],
    ),
  ];

  static final List<VisualQuestion> _colorQuestions = [
    VisualQuestion(
      id: 'c1',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/red.png',
      correctAnswer: 'Rojo',
      options: ['Rojo', 'Naranja', 'Rosa'],
    ),
    VisualQuestion(
      id: 'c2',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/blue.png',
      correctAnswer: 'Azul',
      options: ['Verde', 'Azul', 'Morado'],
    ),
    VisualQuestion(
      id: 'c3',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/yellow.png',
      correctAnswer: 'Amarillo',
      options: ['Amarillo', 'Naranja', 'Dorado'],
    ),
    VisualQuestion(
      id: 'c4',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/green.png',
      correctAnswer: 'Verde',
      options: ['Azul', 'Verde', 'Turquesa'],
    ),
    VisualQuestion(
      id: 'c5',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/purple.png',
      correctAnswer: 'Morado',
      options: ['Rosa', 'Morado', 'Azul'],
    ),
    VisualQuestion(
      id: 'c6',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/orange.png',
      correctAnswer: 'Naranja',
      options: ['Rojo', 'Amarillo', 'Naranja'],
    ),
    VisualQuestion(
      id: 'c7',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/pink.png',
      correctAnswer: 'Rosa',
      options: ['Rosa', 'Rojo', 'Morado'],
    ),
    VisualQuestion(
      id: 'c8',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/brown.png',
      correctAnswer: 'Café',
      options: ['Negro', 'Café', 'Gris'],
    ),
    VisualQuestion(
      id: 'c9',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/black.png',
      correctAnswer: 'Negro',
      options: ['Gris', 'Negro', 'Azul'],
    ),
    VisualQuestion(
      id: 'c10',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/white.png',
      correctAnswer: 'Blanco',
      options: ['Blanco', 'Gris', 'Amarillo'],
    ),
  ];

  static final List<VisualQuestion> _shapeQuestions = [
    VisualQuestion(
      id: 's1',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/circle.png',
      correctAnswer: 'Círculo',
      options: ['Círculo', 'Óvalo', 'Esfera'],
    ),
    VisualQuestion(
      id: 's2',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/square.png',
      correctAnswer: 'Cuadrado',
      options: ['Rectángulo', 'Cuadrado', 'Rombo'],
    ),
    VisualQuestion(
      id: 's3',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/triangle.png',
      correctAnswer: 'Triángulo',
      options: ['Triángulo', 'Pirámide', 'Cono'],
    ),
    VisualQuestion(
      id: 's4',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/rectangle.png',
      correctAnswer: 'Rectángulo',
      options: ['Cuadrado', 'Rectángulo', 'Paralelogramo'],
    ),
    VisualQuestion(
      id: 's5',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/star.png',
      correctAnswer: 'Estrella',
      options: ['Sol', 'Estrella', 'Flor'],
    ),
    VisualQuestion(
      id: 's6',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/heart.png',
      correctAnswer: 'Corazón',
      options: ['Corazón', 'Óvalo', 'Gota'],
    ),
    VisualQuestion(
      id: 's7',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/diamond.png',
      correctAnswer: 'Rombo',
      options: ['Cuadrado', 'Rombo', 'Diamante'],
    ),
    VisualQuestion(
      id: 's8',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/oval.png',
      correctAnswer: 'Óvalo',
      options: ['Círculo', 'Óvalo', 'Elipse'],
    ),
    VisualQuestion(
      id: 's9',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/pentagon.png',
      correctAnswer: 'Pentágono',
      options: ['Hexágono', 'Pentágono', 'Octágono'],
    ),
    VisualQuestion(
      id: 's10',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/hexagon.png',
      correctAnswer: 'Hexágono',
      options: ['Pentágono', 'Heptágono', 'Hexágono'],
    ),
  ];
}
