/// Pregunta del juego
class Question {
  final String id;
  final String categoryId;
  final String imageUrl; // URL de la imagen (local o remota)
  final String correctAnswer;
  final List<String> options; // 3 opciones de respuesta
  final String? audioUrl; // Audio opcional para la respuesta

  Question({
    required this.id,
    required this.categoryId,
    required this.imageUrl,
    required this.correctAnswer,
    required this.options,
    this.audioUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'imageUrl': imageUrl,
    'correctAnswer': correctAnswer,
    'options': options,
    'audioUrl': audioUrl,
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'] as String,
    categoryId: json['categoryId'] as String,
    imageUrl: json['imageUrl'] as String,
    correctAnswer: json['correctAnswer'] as String,
    options: List<String>.from(json['options'] as List),
    audioUrl: json['audioUrl'] as String?,
  );
}

/// Preguntas de prueba (después vendrán del backend)
class MockQuestions {
  static List<Question> getByCategory(String categoryId) {
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

  static final List<Question> _animalQuestions = [
    Question(
      id: 'a1',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/dog.png',
      correctAnswer: 'Perro',
      options: ['Perro', 'Gato', 'León'],
    ),
    Question(
      id: 'a2',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/cat.png',
      correctAnswer: 'Gato',
      options: ['Perro', 'Gato', 'Pájaro'],
    ),
    Question(
      id: 'a3',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/lion.png',
      correctAnswer: 'León',
      options: ['Tigre', 'León', 'Oso'],
    ),
    Question(
      id: 'a4',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/elephant.png',
      correctAnswer: 'Elefante',
      options: ['Elefante', 'Jirafa', 'Hipopótamo'],
    ),
    Question(
      id: 'a5',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/bird.png',
      correctAnswer: 'Pájaro',
      options: ['Mariposa', 'Pájaro', 'Abeja'],
    ),
    Question(
      id: 'a6',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/fish.png',
      correctAnswer: 'Pez',
      options: ['Delfín', 'Ballena', 'Pez'],
    ),
    Question(
      id: 'a7',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/rabbit.png',
      correctAnswer: 'Conejo',
      options: ['Conejo', 'Ratón', 'Ardilla'],
    ),
    Question(
      id: 'a8',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/bear.png',
      correctAnswer: 'Oso',
      options: ['Lobo', 'Oso', 'Zorro'],
    ),
    Question(
      id: 'a9',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/monkey.png',
      correctAnswer: 'Mono',
      options: ['Gorila', 'Chimpancé', 'Mono'],
    ),
    Question(
      id: 'a10',
      categoryId: 'animals',
      imageUrl: 'assets/images/animals/turtle.png',
      correctAnswer: 'Tortuga',
      options: ['Tortuga', 'Cocodrilo', 'Lagarto'],
    ),
  ];

  static final List<Question> _fruitQuestions = [
    Question(
      id: 'f1',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/apple.png',
      correctAnswer: 'Manzana',
      options: ['Manzana', 'Pera', 'Durazno'],
    ),
    Question(
      id: 'f2',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/banana.png',
      correctAnswer: 'Plátano',
      options: ['Plátano', 'Mango', 'Papaya'],
    ),
    Question(
      id: 'f3',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/orange.png',
      correctAnswer: 'Naranja',
      options: ['Limón', 'Naranja', 'Mandarina'],
    ),
    Question(
      id: 'f4',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/strawberry.png',
      correctAnswer: 'Fresa',
      options: ['Cereza', 'Fresa', 'Frambuesa'],
    ),
    Question(
      id: 'f5',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/grape.png',
      correctAnswer: 'Uva',
      options: ['Uva', 'Ciruela', 'Mora'],
    ),
    Question(
      id: 'f6',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/watermelon.png',
      correctAnswer: 'Sandía',
      options: ['Melón', 'Sandía', 'Piña'],
    ),
    Question(
      id: 'f7',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/pear.png',
      correctAnswer: 'Pera',
      options: ['Manzana', 'Pera', 'Kiwi'],
    ),
    Question(
      id: 'f8',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/cherry.png',
      correctAnswer: 'Cereza',
      options: ['Cereza', 'Tomate', 'Fresa'],
    ),
    Question(
      id: 'f9',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/pineapple.png',
      correctAnswer: 'Piña',
      options: ['Coco', 'Piña', 'Mango'],
    ),
    Question(
      id: 'f10',
      categoryId: 'fruits',
      imageUrl: 'assets/images/fruits/peach.png',
      correctAnswer: 'Durazno',
      options: ['Durazno', 'Albaricoque', 'Nectarina'],
    ),
  ];

  static final List<Question> _colorQuestions = [
    Question(
      id: 'c1',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/red.png',
      correctAnswer: 'Rojo',
      options: ['Rojo', 'Naranja', 'Rosa'],
    ),
    Question(
      id: 'c2',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/blue.png',
      correctAnswer: 'Azul',
      options: ['Verde', 'Azul', 'Morado'],
    ),
    Question(
      id: 'c3',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/yellow.png',
      correctAnswer: 'Amarillo',
      options: ['Amarillo', 'Naranja', 'Dorado'],
    ),
    Question(
      id: 'c4',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/green.png',
      correctAnswer: 'Verde',
      options: ['Azul', 'Verde', 'Turquesa'],
    ),
    Question(
      id: 'c5',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/purple.png',
      correctAnswer: 'Morado',
      options: ['Rosa', 'Morado', 'Azul'],
    ),
    Question(
      id: 'c6',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/orange.png',
      correctAnswer: 'Naranja',
      options: ['Rojo', 'Amarillo', 'Naranja'],
    ),
    Question(
      id: 'c7',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/pink.png',
      correctAnswer: 'Rosa',
      options: ['Rosa', 'Rojo', 'Morado'],
    ),
    Question(
      id: 'c8',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/brown.png',
      correctAnswer: 'Café',
      options: ['Negro', 'Café', 'Gris'],
    ),
    Question(
      id: 'c9',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/black.png',
      correctAnswer: 'Negro',
      options: ['Gris', 'Negro', 'Azul'],
    ),
    Question(
      id: 'c10',
      categoryId: 'colors',
      imageUrl: 'assets/images/colors/white.png',
      correctAnswer: 'Blanco',
      options: ['Blanco', 'Gris', 'Amarillo'],
    ),
  ];

  static final List<Question> _shapeQuestions = [
    Question(
      id: 's1',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/circle.png',
      correctAnswer: 'Círculo',
      options: ['Círculo', 'Óvalo', 'Esfera'],
    ),
    Question(
      id: 's2',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/square.png',
      correctAnswer: 'Cuadrado',
      options: ['Rectángulo', 'Cuadrado', 'Rombo'],
    ),
    Question(
      id: 's3',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/triangle.png',
      correctAnswer: 'Triángulo',
      options: ['Triángulo', 'Pirámide', 'Cono'],
    ),
    Question(
      id: 's4',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/rectangle.png',
      correctAnswer: 'Rectángulo',
      options: ['Cuadrado', 'Rectángulo', 'Paralelogramo'],
    ),
    Question(
      id: 's5',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/star.png',
      correctAnswer: 'Estrella',
      options: ['Sol', 'Estrella', 'Flor'],
    ),
    Question(
      id: 's6',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/heart.png',
      correctAnswer: 'Corazón',
      options: ['Corazón', 'Óvalo', 'Gota'],
    ),
    Question(
      id: 's7',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/diamond.png',
      correctAnswer: 'Rombo',
      options: ['Cuadrado', 'Rombo', 'Diamante'],
    ),
    Question(
      id: 's8',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/oval.png',
      correctAnswer: 'Óvalo',
      options: ['Círculo', 'Óvalo', 'Elipse'],
    ),
    Question(
      id: 's9',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/pentagon.png',
      correctAnswer: 'Pentágono',
      options: ['Hexágono', 'Pentágono', 'Octágono'],
    ),
    Question(
      id: 's10',
      categoryId: 'shapes',
      imageUrl: 'assets/images/shapes/hexagon.png',
      correctAnswer: 'Hexágono',
      options: ['Pentágono', 'Heptágono', 'Hexágono'],
    ),
  ];
}
