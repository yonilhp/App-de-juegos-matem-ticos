import 'package:flutter/material.dart';
import 'package:num_num/features/profile_setup/domain/entities/question.dart';
import 'package:num_num/features/profile_setup/domain/entities/category.dart';

/// Estado del juego
enum GameState { initial, playing, correct, wrong, completed }

/// Provider para manejar la lógica del juego
class GameProvider extends ChangeNotifier {
  String? _currentCategoryId;
  Category? _currentCategory;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  GameState _state = GameState.initial;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  String? _selectedAnswer;

  // Getters
  String? get currentCategoryId => _currentCategoryId;
  Category? get currentCategory => _currentCategory;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion =>
      _questions.isNotEmpty && _currentQuestionIndex < _questions.length
      ? _questions[_currentQuestionIndex]
      : null;
  GameState get state => _state;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  int get totalAnswered => _correctAnswers + _wrongAnswers;
  String? get selectedAnswer => _selectedAnswer;

  bool get isGameCompleted => _currentQuestionIndex >= _questions.length;
  int get questionsRemaining => _questions.length - _currentQuestionIndex;
  double get progressPercent =>
      _questions.isNotEmpty ? _currentQuestionIndex / _questions.length : 0;

  /// Iniciar juego con una categoría
  void startGame(String categoryId) {
    _currentCategoryId = categoryId;
    _currentCategory = AppCategories.getById(categoryId);
    _questions = MockQuestions.getByCategory(categoryId);
    _questions.shuffle(); // Mezclar preguntas
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _selectedAnswer = null;
    _state = GameState.playing;
    notifyListeners();
  }

  /// Seleccionar una respuesta
  void selectAnswer(String answer) {
    if (_state != GameState.playing || currentQuestion == null) return;

    _selectedAnswer = answer;

    if (answer == currentQuestion!.correctAnswer) {
      _state = GameState.correct;
      _correctAnswers++;
    } else {
      _state = GameState.wrong;
      _wrongAnswers++;
    }

    notifyListeners();
  }

  /// Avanzar a la siguiente pregunta
  void nextQuestion() {
    _currentQuestionIndex++;
    _selectedAnswer = null;

    if (_currentQuestionIndex >= _questions.length) {
      _state = GameState.completed;
    } else {
      _state = GameState.playing;
    }

    notifyListeners();
  }

  /// Reintentar la pregunta actual (solo si fue incorrecta)
  void retryQuestion() {
    if (_state == GameState.wrong) {
      _selectedAnswer = null;
      _state = GameState.playing;
      notifyListeners();
    }
  }

  /// Reiniciar el juego de la categoría actual
  void restartGame() {
    if (_currentCategoryId != null) {
      startGame(_currentCategoryId!);
    }
  }

  /// Limpiar el estado del juego
  void resetGame() {
    _currentCategoryId = null;
    _currentCategory = null;
    _questions = [];
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _selectedAnswer = null;
    _state = GameState.initial;
    notifyListeners();
  }

  /// Obtener resultado del juego
  GameResult getResult() {
    final total = _correctAnswers + _wrongAnswers;
    final accuracy = total > 0 ? (_correctAnswers / total) * 100 : 0;

    return GameResult(
      categoryId: _currentCategoryId ?? '',
      totalQuestions: _questions.length,
      correctAnswers: _correctAnswers,
      wrongAnswers: _wrongAnswers,
      accuracy: accuracy.toDouble(),
      isPassed: _correctAnswers >= (_questions.length * 0.6), // 60% para pasar
    );
  }
}

/// Resultado del juego
class GameResult {
  final String categoryId;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double accuracy;
  final bool isPassed;

  GameResult({
    required this.categoryId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.accuracy,
    required this.isPassed,
  });

  String get emoji {
    if (accuracy >= 90) return '🌟';
    if (accuracy >= 70) return '😊';
    if (accuracy >= 50) return '👍';
    return '💪';
  }

  String get message {
    if (accuracy >= 90) return '¡Excelente! ¡Eres un genio!';
    if (accuracy >= 70) return '¡Muy bien! ¡Sigue así!';
    if (accuracy >= 50) return '¡Buen trabajo! Puedes mejorar';
    return '¡No te rindas! Inténtalo de nuevo';
  }
}
